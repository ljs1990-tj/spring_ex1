package com.example.test1.dao;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Member;

@Service
public class MemberService {
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	HttpSession session;

	public HashMap<String, Object> memberLogin(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Member member = memberMapper.getMember(map);
		
		if(member != null) {
			System.out.println("성공");
			session.setAttribute("sessionId", member.getUserId());
			session.setAttribute("sessionName", member.getUserName());
			session.setAttribute("sessionStatus", member.getStatus());
			
			resultMap.put("member", member);
			resultMap.put("result", "success");
		} else {
			System.out.println("실패");
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}

	public HashMap<String, Object> addMember(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int num = memberMapper.insertMember(map);
		resultMap.put("result", "success");
		// if num > 0 데이터 삽입 잘 된거 
		// 아니면 뭔가 문제 있는거
		return resultMap;
	}

	public HashMap<String, Object> searchMember(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Member member = memberMapper.selectMember(map);
		
		int count = member != null ? 1 : 0 ;
		resultMap.put("count", count);
//		int count = 0;
//		if(member != null) {
//			count = 1;
//		} else {
//			count = 0;
//		}
		
		return resultMap;
	}
	
}