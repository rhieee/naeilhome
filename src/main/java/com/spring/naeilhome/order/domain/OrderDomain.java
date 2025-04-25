package com.spring.naeilhome.order.domain;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Component;

@Component("OrderDomain")
public class OrderDomain {

	private int orderNo;
	private String memberId;
//	private String orderProductOptions;
	private String orderReceiver;
	private String orderReceiverPhone1;
	private String orderReceiverPhone2;
	private String orderReceiverPhone3;
	private String orderReceiverEmail1;
	private String orderReceiverEmail2;
	private String orderZip1;
	private String orderZip2;
	private String orderZip3;
	private String orderMessage;
	private Date orderDate;
	private String orderPaytype;
	private int productPoint;

	// 다수의 상품 정보를 위한 리스트 필드
	private List<Integer> productNoList;
	private List<Integer> productPriceList;
	private List<Integer> orderQtyList;
	private List<String> orderProductOptionsList; // 옵션 리스트 추가

	private int productNo;
	private int productPrice;
	private String productName;
	private String imageFileName; // 구매페이지 상품 썸네일 이미지 이름
	private int orderQty;
	private String orderProductOptions;

	private int joinNo; // 주문 헤더와 주문상품 조인
	private int orderAmount; // 총 주문금액

	private int orderPoints;
	private int pointRemain; // 잔여포인트

	// getter, setter
	public int getOrderNo() {
		return orderNo;
	}

	public int getPointRemain() {
		return pointRemain;
	}

	public void setPointRemain(int pointRemain) {
		this.pointRemain = pointRemain;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public int getOrderPoints() {
		return orderPoints;
	}

	public void setOrderPoints(int orderPoints) {
		this.orderPoints = orderPoints;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getOrderReceiver() {
		return orderReceiver;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public void setOrderReceiver(String orderReceiver) {
		this.orderReceiver = orderReceiver;
	}

	public String getOrderReceiverPhone1() {
		return orderReceiverPhone1;
	}

	public void setOrderReceiverPhone1(String orderReceiverPhone1) {
		this.orderReceiverPhone1 = orderReceiverPhone1;
	}

	public String getOrderReceiverPhone2() {
		return orderReceiverPhone2;
	}

	public void setOrderReceiverPhone2(String orderReceiverPhone2) {
		this.orderReceiverPhone2 = orderReceiverPhone2;
	}

	public String getOrderReceiverPhone3() {
		return orderReceiverPhone3;
	}

	public void setOrderReceiverPhone3(String orderReceiverPhone3) {
		this.orderReceiverPhone3 = orderReceiverPhone3;
	}

	public String getOrderReceiverEmail1() {
		return orderReceiverEmail1;
	}

	public void setOrderReceiverEmail1(String orderReceiverEmail1) {
		this.orderReceiverEmail1 = orderReceiverEmail1;
	}

	public String getOrderReceiverEmail2() {
		return orderReceiverEmail2;
	}

	public void setOrderReceiverEmail2(String orderReceiverEmail2) {
		this.orderReceiverEmail2 = orderReceiverEmail2;
	}

	public String getOrderZip1() {
		return orderZip1;
	}

	public void setOrderZip1(String orderZip1) {
		this.orderZip1 = orderZip1;
	}

	public String getOrderZip2() {
		return orderZip2;
	}

	public void setOrderZip2(String orderZip2) {
		this.orderZip2 = orderZip2;
	}

	public String getOrderZip3() {
		return orderZip3;
	}

	public void setOrderZip3(String orderZip3) {
		this.orderZip3 = orderZip3;
	}

	public String getOrderMessage() {
		return orderMessage;
	}

	public void setOrderMessage(String orderMessage) {
		this.orderMessage = orderMessage;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public int getOrderQty() {
		return orderQty;
	}

	public void setOrderQty(int orderQty) {
		this.orderQty = orderQty;
	}

	public String getOrderProductOptions() {
		return orderProductOptions;
	}

	public void setOrderProductOptions(String orderProductOptions) {
		this.orderProductOptions = orderProductOptions;
	}

	public int getOrderAmount() {
		return orderAmount;
	}

	public void setOrderAmount(int orderAmount) {
		this.orderAmount = orderAmount;
	}

	public String getOrderPaytype() {
		return orderPaytype;
	}

	public void setOrderPaytype(String orderPaytype) {
		this.orderPaytype = orderPaytype;
	}

	public int getProductPoint() {
		return productPoint;
	}

	public void setProductPoint(int productPoint) {
		this.productPoint = productPoint;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

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

	public List<Integer> getProductNoList() {
		return productNoList;
	}

	public void setProductNoList(List<Integer> productNoList) {
		this.productNoList = productNoList;
	}

	public List<Integer> getProductPriceList() {
		return productPriceList;
	}

	public void setProductPriceList(List<Integer> productPriceList) {
		this.productPriceList = productPriceList;
	}

	public List<Integer> getOrderQtyList() {
		return orderQtyList;
	}

	public void setOrderQtyList(List<Integer> orderQtyList) {
		this.orderQtyList = orderQtyList;
	}

	public List<String> getOrderProductOptionsList() { // 리스트형 옵션 추가
		return orderProductOptionsList;
	}

	public void setOrderProductOptionsList(List<String> orderProductOptionsList) { // 리스트형 옵션 추가
		this.orderProductOptionsList = orderProductOptionsList;
	}

}