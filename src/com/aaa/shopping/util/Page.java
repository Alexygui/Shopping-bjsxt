package com.aaa.shopping.util;

public class Page {
	private static final int PAGE_SIZE = 4;//分也时每页显示的数据条数
	private int currentPage;//当前页
	private int totalSize;//总共的数据条数
	private int totalPages;//总共的页数
	private boolean hasPrevious;//当前页面是否有前一页
	private boolean hasNext;//当前页面是否有下一页
	private boolean hasFirst;// 当前页面是否有第一页
	private boolean hasLast;//当前页面是否有最后一页
	
	
	public Page() {}
	
	// 通过currentPage和totalSize可以计算出其他的值，所以要用这两个参数构造这个类
	public Page(int currentPage, int totalSize) {
		this.currentPage = currentPage;
		this.totalSize = totalSize;
	}


	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getTotalSize() {
		return totalSize;
	}
	public void setTotalSize(int totalSize) {
		this.totalSize = totalSize;
	}
	/**
	 * 通过计算得出总共的页码数，如果整除则是直接返回商的值，如果不是整除则返回商+1的值 
	 */
	public int getTotalPages() {
		totalPages = totalSize / PAGE_SIZE;
		if(totalSize % PAGE_SIZE != 0) {
			return ++totalPages;
		} else {
			return totalPages;
		}
	}
	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}
	
	public boolean isHasPrevious() {
		if(this.isHasFirst()){
			return true;
		} else {
			return false;
		}
	}
	public void setHasPrevious(boolean hasPrevious) {
		this.hasPrevious = hasPrevious;
	}
	public boolean isHasNext() {
		if(this.isHasLast()) {
			return true;
		} else {
			return false;
		}
	}
	public void setHasNext(boolean hasNext) {
		this.hasNext = hasNext;
	}
	//在当前页是第一页的情况下没有首页的选项
	public boolean isHasFirst() {
		if(currentPage <= 1) {
			return false;
		} else {
			return true;
		}
	}
	public void setHasFirst(boolean hasFirst) {
		this.hasFirst = hasFirst;
	}
	//在当前页是最后一页的情况下没有最后一页的选项
	public boolean isHasLast() {
		if(currentPage >= this.getTotalPages()) {
			return false;
		} else {
			return true;
		}
	}
	public void setHasLast(boolean hasLast) {
		this.hasLast = hasLast;
	}
	public static int getPageSize() {
		return PAGE_SIZE;
	}
	
}
