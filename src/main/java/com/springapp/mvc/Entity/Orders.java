package com.springapp.mvc.Entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by helldes on 20.02.2015.
 */
@Entity
@Table(name = "ORDERS")
public class Orders implements Serializable {

    @Id
    @GeneratedValue
    @Column(name = "ORDER_ID")
    private int order_id;

    @Column
    private Date date = new Date();

    @Column
    private int status;

    @Column
    private Double totalPrice;

    @Column
    private String customAddress;

    @OneToOne(mappedBy = "order")
    private Invoice invoice;

    @ManyToOne
    @JoinColumn(name = "USER_ID")
    private User user;

    @OneToMany(mappedBy = "pk.orders")
    private List<OrderDetails> orderDetailses;

    public Invoice getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getCustomAddress() {
        return customAddress;
    }

    public void setCustomAddress(String customAddress) {
        this.customAddress = customAddress;
    }

    public List<OrderDetails> getOrderDetailses() {
        return orderDetailses;
    }

    public void setOrderDetailses(List<OrderDetails> orderDetailses) {
        this.orderDetailses = orderDetailses;
    }
}
