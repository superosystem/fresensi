<?php

interface Animal
{
    function speak();
}

class Tiger implements Animal
{
    function speak()
    {
        echo "Roar!";
    }
}

class Dog implements Animal
{
    function speak()
    {
        echo "Gug Gug!";
    }
}

class Cat implements Animal
{
    function speak()
    {
        echo "Weoawww!";
    }
}