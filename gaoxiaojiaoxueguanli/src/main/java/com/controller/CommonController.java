package com.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.annotation.IgnoreAuth;
import com.baidu.aip.face.AipFace;
import com.baidu.aip.face.MatchRequest;
import com.baidu.aip.util.Base64Util;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.entity.ConfigEntity;
import com.service.CommonService;
import com.service.ConfigService;
import com.utils.BaiduUtil;
import com.utils.FileUtil;
import com.utils.R;

/**
 * 通用接口
 */
@RestController
public class CommonController{

	@Autowired
	private CommonService commonService;
	
	@Autowired
	private ConfigService configService;
	
	private static AipFace client = null;
	
	private static String BAIDU_DITU_AK = null;
	
	@RequestMapping("/location")
	public R location(String lng,String lat) {
		if(BAIDU_DITU_AK==null) {
			BAIDU_DITU_AK = configService.selectOne(new EntityWrapper<ConfigEntity>().eq("name", "baidu_ditu_ak")).getValue();
			if(BAIDU_DITU_AK==null) {
				return R.error("请在配置管理中正确配置baidu_ditu_ak");
			}
		}
		Map<String, String> map = BaiduUtil.getCityByLonLat(BAIDU_DITU_AK, lng, lat);
		return R.ok().put("data", map);
	}
	
	/**
	 * 人脸比对
	 * 
	 * @param face1 人脸1
	 * @param face2 人脸2
	 * @return
	 */
	@RequestMapping("/matchFace")
	public R matchFace(String face1, String face2, HttpServletRequest request) {
		if(client==null) {
			/*String AppID = configService.selectOne(new EntityWrapper<ConfigEntity>().eq("name", "AppID")).getValue();*/
			String APIKey = configService.selectOne(new EntityWrapper<ConfigEntity>().eq("name", "APIKey")).getValue();
			String SecretKey = configService.selectOne(new EntityWrapper<ConfigEntity>().eq("name", "SecretKey")).getValue();
			String token = BaiduUtil.getAuth(APIKey, SecretKey);
			if(token==null) {
				return R.error("请在配置管理中正确配置APIKey和SecretKey");
			}
			client = new AipFace(null, APIKey, SecretKey);
			client.setConnectionTimeoutInMillis(2000);
			client.setSocketTimeoutInMillis(60000);
		}
		JSONObject res = null;
		try {
			File file1 = new File(request.getSession().getServletContext().getRealPath("/upload")+"/"+face1);
			File file2 = new File(request.getSession().getServletContext().getRealPath("/upload")+"/"+face2);
			String img1 = Base64Util.encode(FileUtil.FileToByte(file1));
			String img2 = Base64Util.encode(FileUtil.FileToByte(file2));
			MatchRequest req1 = new MatchRequest(img1, "BASE64");
			MatchRequest req2 = new MatchRequest(img2, "BASE64");
			ArrayList<MatchRequest> requests = new ArrayList<MatchRequest>();
			requests.add(req1);
			requests.add(req2);
			res = client.match(requests);
			System.out.println(res.get("result"));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return R.error("文件不存在");
		} catch (IOException e) {
			e.printStackTrace();
		} 
		return R.ok().put("data", com.alibaba.fastjson.JSONObject.parse(res.get("result").toString()));
	}

	/**
	 * 根据table中的column获取单条记录
	 * @return
	 */
	@RequestMapping("/follow/{tableName}/{columnName}")
	@IgnoreAuth
	public R getFollowByOption(@PathVariable("tableName") String tableName, @PathVariable("columnName") String columnName, @RequestParam String columnValue) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("table", tableName);
		params.put("column", columnName);
		params.put("columnValue", columnValue);
		Map<String, Object> result = commonService.getFollowByOption(params);
		return R.ok().put("data", result);
	}
	
	/**
	 * 修改table表的sfsh状态
	 * @param map
	 * @return
	 */
	@RequestMapping("/sh/{tableName}")
	public R sh(@PathVariable("tableName") String tableName, @RequestBody Map<String, Object> map) {
		map.put("table", tableName);
		commonService.sh(map);
		return R.ok();
	}
	
	/**
	 * 获取需要提醒的记录数
	 * @param tableName
	 * @param columnName
	 * @param type 1:数字 2:日期
	 * @param map
	 * @return
	 */
	@RequestMapping("/remind/{tableName}/{columnName}/{type}")
	@IgnoreAuth
	public R remindCount(@PathVariable("tableName") String tableName, @PathVariable("columnName") String columnName, 
						 @PathVariable("type") String type,@RequestParam Map<String, Object> map) {
		map.put("table", tableName);
		map.put("column", columnName);
		map.put("type", type);
		
		if(type.equals("2")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c = Calendar.getInstance();
			Date remindStartDate = null;
			Date remindEndDate = null;
			if(map.get("remindstart")!=null) {
				Integer remindStart = Integer.parseInt(map.get("remindstart").toString());
				c.setTime(new Date()); 
				c.add(Calendar.DAY_OF_MONTH,remindStart);
				remindStartDate = c.getTime();
				map.put("remindstart", sdf.format(remindStartDate));
			}
			if(map.get("remindend")!=null) {
				Integer remindEnd = Integer.parseInt(map.get("remindend").toString());
				c.setTime(new Date());
				c.add(Calendar.DAY_OF_MONTH,remindEnd);
				remindEndDate = c.getTime();
				map.put("remindend", sdf.format(remindEndDate));
			}
		}
		
		int count = commonService.remindCount(map);
		return R.ok().put("count", count);
	}




	/**
	 * 关联字典表的查图表 column1 是 要统计的 column2 是要展示的 第一个
	 * @return
	 */
	@RequestMapping("/group2/{tableName}/{columnName}")
	@IgnoreAuth
	public R getOption2(@PathVariable("tableName") String tableName, @RequestParam Map<String,Object> params, @PathVariable("columnName") String columnName) {
		params.put("table", tableName);
		params.put("column1", columnName);
		List<String> data = commonService.getOption2(params);
		return R.ok().put("data", data);
	}

	/**
	 * 关联两表关联的 图表统计  column1 是 要统计的 column2 是要展示的 第二个
	 * @return
	 */
	@RequestMapping("/group1/{tableName}/{columnName}")
	@IgnoreAuth
	public R getOption1(@PathVariable("tableName") String tableName, @RequestParam Map<String,Object> params, @PathVariable("columnName") String columnName) {
		params.put("table", tableName);
		params.put("column1", columnName);
		List<String> data = commonService.getOption1(params);
		return R.ok().put("data", data);
	}


	/**
	 * 单表的图表查询
	 */
	@RequestMapping("/group/{tableName}/{columnName}")
	@IgnoreAuth
	public R group(@PathVariable("tableName") String tableName, @PathVariable("columnName") String columnName) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("table", tableName);
		params.put("column", columnName);
		List<Map<String, Object>> result = commonService.selectGroup(params);
		return R.ok().put("data", result);
	}



	/**
	 * 单列求和
	 */
	@RequestMapping("/cal/{tableName}/{columnName}")
	@IgnoreAuth
	public R cal(@PathVariable("tableName") String tableName, @PathVariable("columnName") String columnName) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("table", tableName);
		params.put("column", columnName);
		Map<String, Object> result = commonService.selectCal(params);
		return R.ok().put("data", result);
	}
	/**
	 * （按值统计）
	 */
	@RequestMapping("/value/{tableName}/{xColumnName}/{yColumnName}")
	@IgnoreAuth
	public R value(@PathVariable("tableName") String tableName, @PathVariable("yColumnName") String yColumnName, @PathVariable("xColumnName") String xColumnName) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("table", tableName);
		params.put("xColumn", xColumnName);
		params.put("yColumn", yColumnName);
		List<Map<String, Object>> result = commonService.selectValue(params);
		return R.ok().put("data", result);
	}
	
}
