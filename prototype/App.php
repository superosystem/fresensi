<?php

$store1 = new Store("Toko X", "Kuningan", "Indonesia", "Gadget");
$store2 = $store1->clone();
$store2->setName("Toko Y");

$store3 = $store1->clone();
$store3->setName("Toko Z");
$store3->setCategory("Fashion");
