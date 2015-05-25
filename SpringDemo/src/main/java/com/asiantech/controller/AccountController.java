package com.asiantech.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.asiantech.model.Account;
import com.asiantech.service.AccountService;

@Controller
public class AccountController {
	@Autowired
	@Qualifier(AccountService.NAME)
	AccountService accountSv;

	@RequestMapping("/getAccounts")
	public ModelAndView getAccountList(
			@RequestParam(required = false) Integer record,
			@ModelAttribute("account") Account account) {
		Map<String, Object> map = new HashMap<String, Object>();
		int numOfPage = 1;
		if (record == null)
			map.put("Accounts", getRecord1to5());
		else {
			map.put("Accounts", getRecordLimitOff(record));
			numOfPage = record;
		}
		map.put("account", account);
		map.put("numCountRows", accountSv.getCount());
		map.put("numPages", getNumPagination());
		map.put("numOfPage", numOfPage);

		return new ModelAndView("index", "map", map);
	}

	 

	public List<Account> getRecord1to5() {
		return accountSv.getAll();
	}

	public List<Account> getRecordLimitOff(int record) {
		int maxRows = 5;
		return accountSv.getLimit(maxRows, (record - 1) * maxRows);
	}

	public int getNumPagination() {
		int numRows, numPages, maxRows = 5;
		numRows = accountSv.getCount();
		numPages = numRows / maxRows;
		if (numRows % maxRows != 0)
			numPages++;
		return numPages;
	}

	@RequestMapping("/vali")
	public String aaa() {
		 
		return "valiadation"; 
	}
}
