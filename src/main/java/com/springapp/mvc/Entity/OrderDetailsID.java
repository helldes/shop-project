package com.springapp.mvc.Entity;

import javax.persistence.Embeddable;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import java.io.Serializable;

/**
 * Created by helldes on 22.02.2015.
 */
@SuppressWarnings("serial")
@Embeddable
public class OrderDetailsID  implements Serializable{

    private Product product;
    private Orders orders;
    @Id
    private int id;

    @ManyToOne
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @ManyToOne
    public Orders getOrders() {
        return orders;
    }

    public void setOrders(Orders orders) {
        this.orders = orders;
    }
}
