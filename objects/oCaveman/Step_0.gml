action_inherited();
if (active)
{
moveTo(xVel,yVel);

if (not held) yVel += myGrav;
if (yVel > yVelLimit) yVel = yVelLimit;

colLeft = false;
colRight = false;
colBot = false;
colTop = false;
if (isCollisionLeft(1)) colLeft = true;
if (isCollisionRight(1)) colRight = true;
if (isCollisionBottom(1)) colBot = true;
if (isCollisionTop(1)) colTop = true;

if (status >= STUNNED)
{
    if (collision_point(x+8, y+12, oSolid, 0, 0))
    {
        scrCreateBlood(x+8, y+8, 3);
        playSound(global.sndCavemanDie);
        instance_destroy();
    }
}
else if (not held)
{
    if (collision_point(x+8, y+8, oSolid, 0, 0))
    {
        scrCreateBlood(x+8, y+8, 3);
        playSound(global.sndCavemanDie);
        instance_destroy();
    }
}

if (status != DEAD and status != STUNNED and hp < 1)
{
    status = DEAD;
}

if (colBot and status != STUNNED)
    yVel = 0;

if (status == IDLE)
{
    bounced = false;
    if (colBot and
        (collision_point(x-1, y, oSolid, -1, -1) or collision_point(x+16, y, oSolid, -1, -1)))
    {
        yVel = -6;
        if (facing == LEFT) xVel = -1;
        else xVel = 1;
        counter -= 10;
    }
    
    if (yVel < 0 and colTop)
    {
        yVel = 0;
    }

    if (colBot and counter > 0) counter -= 1;    
    if (counter < 1)
    {
        facing = rand(0,1);
        status = WALK;
    }
    if (sightCounter > 0) sightCounter -= 1;
    else
    {
        sight = instance_create(x, y, oEnemySight);
        if (facing == LEFT) sight.direction = 180;
        else sight.direction = 0;
        sight.speed = 10;
        sight.owner = instance_place(x, y, oCaveman);
        sightCounter = 5;
    }
}
else if (status == WALK)
{
    if (colLeft or colRight)
    {
        if (facing == LEFT) facing = RIGHT;
        else facing = LEFT;
    }
    
    if (facing == LEFT)
    {
        if (not collision_point(x-1, y+16, oSolid, -1, -1))
        {
            status = IDLE;
            counter = rand(20,50);
            xVel = 0;
        }
        xVel = -1.5;
    }
    else
    {
        if (not collision_point(x+16, y+16, oSolid, -1, -1))
        {
            status = IDLE;
            counter = rand(20,50);
            xVel = 0;
        }
        xVel = 1.5;
    }
    
    if (rand(1,100) == 1)
    {
        status = IDLE;
        counter = rand(20,50);
        xVel = 0;
    }
    
    if (sightCounter > 0) sightCounter -= 1;
    else
    {
        sight = instance_create(x, y, oEnemySight);
        if (facing == LEFT) sight.direction = 180;
        else sight.direction = 0;
        sight.speed = 10;
        sight.owner = instance_place(x, y, oCaveman);
        sightCounter = 5;
    }
}
else if (status == ATTACK)
{
    image_speed = 1;
    if (colLeft or colRight)
    {
        if (facing == LEFT) facing = RIGHT;
        else facing = LEFT;
    }
    if (facing == LEFT) xVel = -3;
    else xVel = 3;
}
else if (status == STUNNED)
{
    if (xVel == 0 and hp > 0) sprite_index = sCavemanStunL;
    else if (bounced)
    {
        if (yVel < 0) sprite_index = sCavemanBounceL;
        else sprite_index = sCavemanFallL;
    }
    else
    {
        if (abs(xVel) > 0) sprite_index = sCavemanDieLL;
        else sprite_index = sCavemanDieLR;
    }
    
    if (colBot and not bounced)
    {
        bounced = true;
        scrCreateBlood(x+8, y+8, 1);
    }
    
    if (held or colBot)
    {      
        if (counter > 0) counter -= 1;
        else if (hp > 0)
        {
            status = IDLE;
            if (held)
            {
                held = false;
                with oPlayer1 { holdItem = 0; pickupItemType = ""; }
            }
        }
    }
}
else if (status == DEAD)
{
    if (not dead)
    {
        if (countsAsKill)
        {
            if (isRealLevel()) global.enemyKills[4] += 1;
            global.cavemen += 1;
            global.kills += 1;
        }
        playSound(global.sndCavemanDie);
        dead = true;
    }

    sprite_index = sCavemanDeadL;
    
    if (abs(xVel) > 0 or abs(yVel) > 0) status = STUNNED;
}

if (status >= STUNNED)
{
    scrCheckCollisions();
    
    if (xVel == 0 and yVel == 0 and hp < 1) status = DEAD;
}

if (xVel > 0) xVel -= 0.1;
if (xVel < 0) xVel += 0.1;
if (abs(xVel) < 0.5) xVel = 0;

if (status < STUNNED)
{
    if (abs(xVel) > 0) sprite_index = sCavemanRunLeft;
    else sprite_index = sCavemanLeft;
}
if (held)
{
    if (hp > 0) sprite_index = sCavemanHeldL;
    else sprite_index = sCavemanDHeldL;
}
}
