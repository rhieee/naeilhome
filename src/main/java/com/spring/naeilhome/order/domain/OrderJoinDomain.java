package com.spring.naeilhome.order.domain;

public class OrderJoinDomain {

	private int joinNo;
    private int productNo;
    private String orderProductOptions;
    private int orderQty;
    private int orderPoints;
    private String orderCoupon; 
    private int orderAmount;
    private String orderStatement;
    
    
    // getter, setter
	public int getJoinNo() {
		return joinNo;
	}
	public void setJoinNo(int joinNo) {
		this.joinNo = joinNo;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public int getOrderQty() {
		return orderQty;
	}
	public void setOrderQty(int orderQty) {
		this.orderQty = orderQty;
	}
	public int getOrderPoints() {
		return orderPoints;
	}
	public void setOrderPoints(int orderPoints) {
		this.orderPoints = orderPoints;
	}
	public String getOrderCoupon() {
		return orderCoupon;
	}
	public void setOrderCoupon(String orderCoupon) {
		this.orderCoupon = orderCoupon;
	}
	public int getOrderAmount() {
		return orderAmount;
	}
	public void setOrderAmount(int orderAmount) {
		this.orderAmount = orderAmount;
	}
	public String getOrderProductOptions() {
		return orderProductOptions;
	}
	public void setOrderProductOptions(String orderProductOptions) {
		this.orderProductOptions = orderProductOptions;
	}
	public String getOrderStatement() {
		return orderStatement;
	}
	public void setOrderStatement(String orderStatement) {
		this.orderStatement = orderStatement;
	}
    
    
}
