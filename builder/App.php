<?php

$customer1 = (new CustomerBuilder())
    ->setFistName("Gusryl")
    ->setPhone("12131")
    ->setAge(22)
    ->build();

$customer2 = (new CustomerBuilder())
    ->setFistName("Gusryl")
    ->setAddress("Jakarta")
    ->setPhone("12131")
    ->setAge(22)
    ->build();

$customer3 = (new CustomerBuilder())
    ->setFistName("Gusryl")
    ->setLastName("Mubarok")
    ->setPhone("12131")
    ->setAge(22)
    ->build();

$customer4 = (new CustomerBuilder())
    ->setFistName("Gusryl")
    ->setLastName("Mubarok")
    ->setPhone("12131")
    ->setAge(22)
    ->setHobby("Reading")
    ->build();
    
?>