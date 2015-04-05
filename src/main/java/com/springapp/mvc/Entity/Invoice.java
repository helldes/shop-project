package com.springapp.mvc.Entity;

import javax.persistence.*;

/**
 * Created by helldes on 31.03.2015.
 */
@Entity
@Table(name = "INVOICE")
public class Invoice {
    @Id
    @GeneratedValue
    @Column(name = "INVOICE_ID")
    private int id;

    @Column(name = "NAME")
    private String name;

    @OneToOne
    @JoinColumn(name ="ORDER_ID")
    private Orders order;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Orders getOrder() {
        return order;
    }

    public void setOrder(Orders order) {
        this.order = order;
    }
}
