package com.springapp.mvc.Entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by helldes on 25.03.2015.
 */
@Entity
@Table(name = "NEWS")
public class News implements Serializable {
    @Id
    @GeneratedValue
    @Column(name = "NEWS_ID")
    private int id;

    @Column(name = "TITLE")
    private String title;

    @Column(name = "DATE")
    private Date date = new Date();

    @Column(name = "DESCRIPTION")
    private String description;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}