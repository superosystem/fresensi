<?php

class AnimalFactory
{
    public static function create($type): Animal
    {
        if($type == "Tiger") {
            return new Tiger();
        }else if($type == "Cat") {
            return new Cat();
        }else  if($type == "Dog") {
            return new Dog();
        }
    }
}