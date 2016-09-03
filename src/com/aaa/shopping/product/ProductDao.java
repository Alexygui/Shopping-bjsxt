package com.aaa.shopping.product;

import java.util.List;

public interface ProductDao {
	
	public void addProduct(Product product);
	public List<Product> getProducts();
}
