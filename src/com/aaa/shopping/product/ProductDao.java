package com.aaa.shopping.product;

import java.util.List;

import com.aaa.shopping.util.Page;

public interface ProductDao {
	
	public void addProduct(Product product);
	public List<Product> getProducts();
	public Page getPage(int currentPage);
	public Product getProductById(int id);
	public void updateProduct(Product product);
}
