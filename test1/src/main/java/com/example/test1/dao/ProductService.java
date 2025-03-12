package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.ProductMapper;
import com.example.test1.model.Product;

@Service
public class ProductService {

	@Autowired
	ProductMapper productMapper;

	public HashMap<String, Object> getProductList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Product> list = productMapper.selectProductList(map);
		resultMap.put("result", "success");
		resultMap.put("list", list);

		return resultMap;
	}

	public HashMap<String, Object> getProduct(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Product info = productMapper.selectProduct(map);
		List<Product> imgList = productMapper.selectProductImg(map);
		resultMap.put("result", "success");
		resultMap.put("info", info);
		resultMap.put("imgList", imgList);

		return resultMap;
	}

	public HashMap<String, Object> addProduct(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int num = productMapper.insertProduct(map);
		if(num > 0) {
			resultMap.put("itemNo", map.get("itemNo"));
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public void addProductFile(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			 productMapper.insertProductFile(map);
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
	}
	
}
