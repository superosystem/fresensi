<?php

class Game
{
    private $level;
    private $arena;

    public function __construct(GameFactory $gameFactory)
    {
        $this->level = $gameFactory->createLevel();
        $this->arena = $gameFactory->createArena(); 
    }

    function start()
    {
        $this->level->start();
        $this->arena->start();
    }
}