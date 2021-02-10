<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>

html {
  box-sizing: border-box;
}
*, *:before, *:after {
    box-sizing: inherit;
}

/* Item atlas: 
 *  - https://i.imgur.com/ngGK5MF.png
 *  - https://s3-us-west-2.amazonaws.com/s.cdpn.io/8709/item-atlas.png
 * Table/Inventory atlas:
 *  - https://i.imgur.com/nOqKSbE.png
 *  - https://s3-us-west-2.amazonaws.com/s.cdpn.io/8709/inventory-atlas.png
*/

.inventory-row
{
   display: flex;
	flex-direction: row;
	justify-content: flex-start; /* align items in Main Axis */
	align-items: flex-start; /* align items in Cross Axis */
	align-content: flex-start; /* Extra space in Cross Axis */
}


.inventory-cell
{
    width: 36px;
    height: 36px;
    
    flex-shrink: 0;
    
    display: flex;
    flex-direction: row;
    justify-content: center; /* align items in Main Axis */
    align-items: center; /* align items in Cross Axis */
    align-content: center; /* Extra space in Cross Axis */
    
    background-image: url('https://s3-us-west-2.amazonaws.com/s.cdpn.io/8709/inventory-atlas.png');
    background-position: -229px -331px;
}

/* left */
.inventory-cell:first-child
{
    width: 38px;
    padding-left: 2px;
    
    background-position: -190px -331px;
}

/* right */
.inventory-cell:last-child
{
    width: 38px;
    padding-right: 2px;
    
    background-position: -266px -331px;
}
    

/* top ROW */
.inventory-row:first-child .inventory-cell
{
    height: 38px;
    padding-top: 2px;
    
    background-position: -229px -292px;
}

/* bottom ROW */
.inventory-row:last-child .inventory-cell
{
    height: 38px;
    padding-bottom: 2px;
    
    background-position: -229px -368px;
}

/* top left */
.inventory-row:first-child .inventory-cell:first-child
{
    width: 38px;
    height: 38px;
    
    background-position: -190px -292px;
}

/* top right */
.inventory-row:first-child .inventory-cell:last-child
{
    width: 38px;
    height: 38px;
    
    background-position: -266px -292px;
}

/* bottom left */
.inventory-row:last-child .inventory-cell:first-child
{
    width: 38px;
    height: 38px;
    
    background-position: -190px -368px;
}

/* bottom right */
.inventory-row:last-child .inventory-cell:last-child
{
    width: 38px;
    height: 38px;
    
    background-position: -266px -368px;
}


/* single horizontal */
.inventory-row:only-child .inventory-cell
{
    height: 40px;
    
    background-position: -613px -286px;
}
/* single horizontal left */
.inventory-row:only-child .inventory-cell:first-child
{
    width: 38px;
    height: 40px;
    
    background-position: -574px -286px;
}
/* single horizontal right */
.inventory-row:only-child .inventory-cell:last-child
{
    width: 38px;
    height: 40px;
    
    background-position: -650px -286px;
}

/* single vertical */
.inventory-row .inventory-cell:only-child
{
    width: 40px;
    
    background-position: -563px -463px;
}
/* single vertical top */
.inventory-row:first-child .inventory-cell:only-child
{
    width: 40px;
    height: 38px;
    
    background-position: -563px -424px;
}
/* single vertical bottom */
.inventory-row:last-child .inventory-cell:only-child
{
    width: 40px;
    height: 38px;
    
    background-position: -563px -500px;
}

/* single by singel */
.inventory-row:only-child .inventory-cell:only-child
{
    width: 40px;
    height: 40px;
    
    background-position: -30px -288px;
}



/* ITEMS */

.inventory-item
{
    width: 34px;
    height: 34px;
    background-image: url('https://s3-us-west-2.amazonaws.com/s.cdpn.io/8709/item-atlas.png');
    background-repeat: no-repeat;
    
    cursor: hand;
    cursor: pointer;
    
    -webkit-transition: opacity 0.3s ease;
    transition: opacity 0.3s ease;
}

.inventory-item-sortable-placeholder
{
    display: none;
}

.inventory-item.ui-sortable-helper, .inventory-item.ui-draggable-dragging
{
    opacity: .6;
}

.inventory-item.grape
{
    background-position: 0px 0px;
}
.inventory-item.carrot
{
    background-position: -34px -34px;
}
.inventory-item.sword1
{
    background-position: 0px -170px;
}
.inventory-item.fire-sword1
{
    background-position: -34px -952px;
}
.inventory-item.axe1
{
    background-position: -170px -340px;
}
.inventory-item.fire-axe1
{
    background-position: -306px -340px;
}
.inventory-item.fire-bow1
{
    background-position: -238px -374px;
}
.inventory-item.meat1
{
    background-position: -374px -34px;
}
.inventory-item.meat1-cooked
{
    background-position: -442px -34px;
}


</style>



</style>
