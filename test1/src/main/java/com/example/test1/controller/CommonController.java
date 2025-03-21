package com.example.test1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.CommonService;
import com.google.gson.Gson;

@Controller
public class CommonController {

	@Autowired
	CommonService commonService;
	
	@RequestMapping("/map.do") 
    public String result(Model model) throws Exception{
        return "/map"; 
    }
	
	@RequestMapping("/slider.do") 
    public String sample2(Model model) throws Exception{
        return "/slider"; 
    }
	
	@RequestMapping("/date.do") 
    public String date(Model model) throws Exception{
        return "/date"; 
    }
	
	@RequestMapping(value = "/menu.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String get(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = commonService.getMenuList(map); 
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/payment.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String payment(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = commonService.addPayment(map); 
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("/chat.do") 
    public String chat(Model model) throws Exception{
        return "/chat"; 
    }
	
	@RequestMapping("/gemini.do") 
    public String gemini(Model model) throws Exception{
        return "/gemini"; 
    }
}
