package com.all.light.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;

public class CaldictionaryDAO extends SqlSessionDaoSupport {

	@Autowired
	SqlSessionTemplate session;
	
	
	
}
