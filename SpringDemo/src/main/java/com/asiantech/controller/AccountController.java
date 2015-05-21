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

import com.asiantech.model.Account;
import com.asiantech.service.AccountService;

@Controller
public class AccountController {
	@Autowired
	@Qualifier(AccountService.NAME)
	AccountService accountSv;
	String message;

	@RequestMapping("/getList")
	public ModelAndView getUserLIst(@ModelAttribute("account") Account account) {
		List<Account> accountList = accountSv.getAll();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("Accounts", accountList);
		map.put("account", account);
		map.put("mess", message);
		return new ModelAndView("index", "map", map);
	}

	@RequestMapping(value = "/saveAccount", method = RequestMethod.POST)
	public String saveAccount(@ModelAttribute("account") Account account) { 
		if (account != null)
			accountSv.save(account); 
		message = " Saved id = " + account.getId();
		return "redirect:/getList";
	}

	@RequestMapping("/register")
	public String getPageRes() {
		message = " ";
		return "redirect:/getList";
	} 
	
	@RequestMapping("/delete")
	public String deleteAccount(@RequestParam int id) {
		message = " Deleted id = " + id;

		accountSv.deleteById(id);
		return "redirect:/getList";
	}

	@RequestMapping("/edit")
	public ModelAndView editAccount(@RequestParam int id,
			@ModelAttribute Account account) {
		account = accountSv.getById(id);
		List<Account> accountList = accountSv.getAll();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("Accounts", accountList);
		map.put("account", account);
		map.put("mess", message);	
		return new ModelAndView("index", "map", map);
	}

}
