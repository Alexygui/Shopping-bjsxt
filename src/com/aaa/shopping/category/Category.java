package com.aaa.shopping.category;

public class Category {
	/**
	 * 最多三个级别
	 */
	public static final int MAX_GRADE = 3;
	/**
	 * 每个级别两位数字表示
	 */
	public static final int LEVEL_LENGTH = 2;
	
	private int id;//类别id
	private int pid;//类别的父id
	private String name;
	private String descr;
	/**
	 * 该种类属于哪个级别的表示的数字串编码，如果MAX_GRADE = 3；LEVEL_LENGTH = 2;的话则为6位数的编码
	 */
	private int cno; 
	
	private int grade;//三个级别的那个级别，从大类到小类分别用1，2，3...表示
	
	public Category() {}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}

	public int getCno() {
		return cno;
	}

	public void setCno(int cno) {
		this.cno = cno;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}
		
	
}
