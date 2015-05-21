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
	public ModelAndView getAccountList(@RequestParam int record,@ModelAttribute("account") Account account) {
		 
		int numRows, maxRows = 5;
		List<Account> accountList = accountSv.getLimit(maxRows,(record-1)*maxRows);
		numRows = accountSv.getCount(); 
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("Accounts", accountList);
		map.put("account", account);
		map.put("numRows", numRows);
		map.put("numPages", getPagesIndex()); 
		 
		return new ModelAndView("index", "map", map);
	} 
	@RequestMapping("/getList")
	public ModelAndView getAccounts(@ModelAttribute("account") Account account) { 
		 
		List<Account> accountList = accountSv.getAll();  
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("Accounts", accountList);
		map.put("account", account);
		map.put("numRows", accountSv.getCount());
		map.put("numPages", getPagesIndex()); 
		return new ModelAndView("index", "map", map);
	}

	@RequestMapping(value = "/saveAccount", method = RequestMethod.POST)
	public String saveAccount(@ModelAttribute("account") Account account) {  
		  
		accountSv.save(account); 
		return "redirect:/getAccounts?record="+getPagesIndex();
	} 
	public int getPagesIndex(){
		int numRows,numPages,maxRows = 5;	
		numRows = accountSv.getCount();
		numPages = numRows / maxRows;
		if(numRows % maxRows != 0 )
			numPages++;
		return numPages;
	}
	@RequestMapping("/delete")
	public String deleteAccount(@RequestParam int id) { 
		accountSv.deleteById(id);  
		return "redirect:/getAccounts?record="+getPagesIndex();
	}

	@RequestMapping("/edit")
	public String editAccount(@RequestParam int id,
			@ModelAttribute Account account,RedirectAttributes redirectAttrs){ 
		account = accountSv.getById(id); 
		redirectAttrs.addFlashAttribute(account); 
		//redirectAttrs.addAttribute(account);
		return "redirect:/getAccounts?record="+getPagesIndex();
	}

}
