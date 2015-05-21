package com.asiantech.service;
 
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Repository; 

import com.asiantech.dao.AccountDao;
import com.asiantech.model.Account;  

@Repository(AccountService.NAME)
public class AccountServiceImpl implements AccountService{
	 
 	@Autowired 
	private AccountDao accdao;

	public void save(Account account) {
		accdao.save(account); 
	}

	public Account getById(int id) {
		Account account = accdao.getById(id);
		return account;
	}

	public void deleteById(int id) {
		accdao.deleteById(id); 
	}

	public List<Account> getAll() {
		List<Account> listAccount = new ArrayList<Account>();
		listAccount = accdao.getAll();
		return listAccount;
	}
	
	
}
