package com.asiantech.dao;

import java.util.ArrayList; 
import java.util.List;  

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate; 
import org.springframework.stereotype.Service;

import com.asiantech.jdbc.AccountRowMapper;
import com.asiantech.model.Account; 
@Service(AccountDao.NAME) 
public class AccountDaoImpl implements AccountDao {
	@Autowired
	JdbcTemplate jdbcTemplate;

	public AccountDaoImpl() {  
	}

	public void save(Account account) {
		System.out.println(account.getId()); 
		if (account.getId() > 0) {
			// update
			String sql = "UPDATE Account SET name=?, modiferTime=?, status=?, isPublic=? WHERE id=?";
			jdbcTemplate.update(sql, account.getName(), account.getTime(),
							account.getStatus(), account.getIsPublic(),
							account.getId());
		} else {
			// insert
			String sql = "INSERT INTO Account (name, modiferTime, status, isPublic)"
					+ " VALUES (?, ?, ?, ?)";
			jdbcTemplate.update(sql, account.getName(), account.getTime(),
					account.getStatus(), account.getIsPublic());
		}

	}
 
	public Account getById(int id) {
		String sql = "SELECT * FROM Account WHERE id = ?";

		Account account = (Account) jdbcTemplate.queryForObject(sql,
				new Object[] { id }, new AccountRowMapper());

		return account;
	}

	public void deleteById(int id) {
		String sql = "DELETE FROM Account WHERE id=?";
		jdbcTemplate.update(sql, id);
	}

	public List<Account> getAll() {
		String sql = "SELECT * FROM Account";
		List<Account> listAccount = new ArrayList<Account>();
		listAccount = jdbcTemplate.query(sql, new AccountRowMapper());  
		return listAccount;
	}

}
