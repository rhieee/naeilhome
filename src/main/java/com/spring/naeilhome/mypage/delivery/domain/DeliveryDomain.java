package com.spring.naeilhome.mypage.delivery.domain;

import java.sql.Date;
import java.util.Objects;

import org.springframework.stereotype.Component;

@Component("deliveryDomain")
public class DeliveryDomain { // (배송)

	private int deliveryNO; // 배송관리 번호(PK)
	private String memberId; // 회원 아이디(FK)
	private int orderNO; // 주문번호(FK)
	private String deliveryStatus; // 배송상태('배송준비', '배송중', '배송완료')
	private Date deliveryStart; // 배송 시작일
	private Date deliveryEnd; // 배송 완료일
	// orders
	private Date orderDate;
	// ordersJoin
	private int joinNO; // orders와 JOIN시키기 위한 구분
	private int productNO; // ordersJoin 테이블의 상품번호
	private String orderProductOptions; // ordersJoin 테이블의 상품옵션
	private int orderQty; // ordersJoin 테이블의 상품수량
	private int orderAmount; // ordersJoin 테이블의 구매금액
	private String orderStatement; // ordersJoin 테이블의 처리상태('결제완료', '구매확정', '취소', '반품중', '반품완료', '교환중', '교환완료')
	// product
	private String productName; // 상품명
	private String productDescription; // 상품 상세설명
	// image
	private String imageFilename; // 이미지 파일명

	// DB에서 가져올 때 쓰는 애들
	private int orderCount; // ordersJoin 테이블의 처리상태 count
	private int deliveryCount; // 배송상태 count
	private String status; // 결제완료, 배송준비, 배송중, 배송완료, 구매확정
	private String mi; // 리뷰테이블 리뷰번호 - 그냥 존재여부 확인하기위함
	public int getDeliveryNO() {
		return deliveryNO;
	}
	public void setDeliveryNO(int deliveryNO) {
		this.deliveryNO = deliveryNO;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public int getOrderNO() {
		return orderNO;
	}
	public void setOrderNO(int orderNO) {
		this.orderNO = orderNO;
	}
	public String getDeliveryStatus() {
		return deliveryStatus;
	}
	public void setDeliveryStatus(String deliveryStatus) {
		this.deliveryStatus = deliveryStatus;
	}
	public Date getDeliveryStart() {
		return deliveryStart;
	}
	public void setDeliveryStart(Date deliveryStart) {
		this.deliveryStart = deliveryStart;
	}
	public Date getDeliveryEnd() {
		return deliveryEnd;
	}
	public void setDeliveryEnd(Date deliveryEnd) {
		this.deliveryEnd = deliveryEnd;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public int getJoinNO() {
		return joinNO;
	}
	public void setJoinNO(int joinNO) {
		this.joinNO = joinNO;
	}
	public int getProductNO() {
		return productNO;
	}
	public void setProductNO(int productNO) {
		this.productNO = productNO;
	}
	public String getOrderProductOptions() {
		return orderProductOptions;
	}
	public void setOrderProductOptions(String orderProductOptions) {
		this.orderProductOptions = orderProductOptions;
	}
	public int getOrderQty() {
		return orderQty;
	}
	public void setOrderQty(int orderQty) {
		this.orderQty = orderQty;
	}
	public int getOrderAmount() {
		return orderAmount;
	}
	public void setOrderAmount(int orderAmount) {
		this.orderAmount = orderAmount;
	}
	public String getOrderStatement() {
		return orderStatement;
	}
	public void setOrderStatement(String orderStatement) {
		this.orderStatement = orderStatement;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductDescription() {
		return productDescription;
	}
	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}
	public String getImageFilename() {
		return imageFilename;
	}
	public void setImageFilename(String imageFilename) {
		this.imageFilename = imageFilename;
	}
	public int getOrderCount() {
		return orderCount;
	}
	public void setOrderCount(int orderCount) {
		this.orderCount = orderCount;
	}
	public int getDeliveryCount() {
		return deliveryCount;
	}
	public void setDeliveryCount(int deliveryCount) {
		this.deliveryCount = deliveryCount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getMi() {
		return mi;
	}
	public void setMi(String mi) {
		this.mi = mi;
	}
	public DeliveryDomain() {
	}
	public DeliveryDomain(int deliveryNO, String memberId, int orderNO, String deliveryStatus, Date deliveryStart,
			Date deliveryEnd, Date orderDate, int joinNO, int productNO, String orderProductOptions, int orderQty,
			int orderAmount, String orderStatement, String productName, String productDescription, String imageFilename,
			int orderCount, int deliveryCount, String status, String mi) {
		this.deliveryNO = deliveryNO;
		this.memberId = memberId;
		this.orderNO = orderNO;
		this.deliveryStatus = deliveryStatus;
		this.deliveryStart = deliveryStart;
		this.deliveryEnd = deliveryEnd;
		this.orderDate = orderDate;
		this.joinNO = joinNO;
		this.productNO = productNO;
		this.orderProductOptions = orderProductOptions;
		this.orderQty = orderQty;
		this.orderAmount = orderAmount;
		this.orderStatement = orderStatement;
		this.productName = productName;
		this.productDescription = productDescription;
		this.imageFilename = imageFilename;
		this.orderCount = orderCount;
		this.deliveryCount = deliveryCount;
		this.status = status;
		this.mi = mi;
	}
		
}
