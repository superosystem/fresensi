<?php

$manager1 = EmployeeFactory::createManager("Gusryl");
$manager2 = EmployeeFactory::createManager("Mubarok");

$staff1 = EmployeeFactory::createStaff("Joko");
$staff2 = EmployeeFactory::createStaff("Budi");

$tiger = AnimalFactory::create("Tiger");
$cat = AnimalFactory::create("Cat");
$dog = AnimalFactory::create("Dog");