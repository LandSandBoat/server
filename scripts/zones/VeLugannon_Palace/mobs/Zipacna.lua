-----------------------------------
-- Area: VeLugannon Palace
--  Mob: Zipacna
-----------------------------------
---@type TMobEntity
local entity = {}

local ID = zones[xi.zone.VELUGANNON_PALACE]

-- Spawn points from nm_spawn_points.sql
local spawnPoints =
{
    blueShort   = { x = -196, y = 0,  z = 389 },
    blueLong    = { x = -121, y = 16, z = 420 },
    yellowShort = { x =  191, y = 0,  z = 399 },
    yellowLong  = { x =  141, y = 16, z = 440 },
}

local pathingDirection =
{
    TO_EAST = 0,
    TO_WEST = 1,
}

local currentDirection = pathingDirection.TO_EAST

local paths =
{
    BLUE_TO_BASEMENT   = 1,
    BLUE_TO_BLUE       = 2,
    BLUE_TO_YELLOW     = 3,
    YELLOW_TO_YELLOW   = 4,
    YELLOW_TO_BASEMENT = 5,
    BLUE_SPAWN_SHORT   = 6,
    BLUE_SPAWN_LONG    = 7,
    YELLOW_SPAWN_SHORT = 8,
    YELLOW_SPAWN_LONG  = 9,
}

local pathNodes =
{
    [paths.BLUE_TO_BASEMENT] =
    {
        -- From first blue door to the blue basement loop
        { x = -162, y = 0,   z = 380 }, -- First Blue Door
        { x = -171, y = 0,   z = 379 },
        { x = -178, y = 0,   z = 380 },
        { x = -187, y = 0,   z = 381 },
        { x = -192, y = 0,   z = 387 },
        { x = -193, y = 0,   z = 395 },
        { x = -194, y = 0,   z = 405 },
        { x = -201, y = 0,   z = 408 },
        { x = -208, y = 0,   z = 403 },
        { x = -208, y = 0,   z = 395 },
        { x = -208, y = 0,   z = 388 },
        { x = -212, y = 0,   z = 382 },
        { x = -220, y = 0,   z = 379 },
        { x = -238, y = 0,   z = 380 }, --start of steps down to basement
        { x = -245, y = 1,   z = 380 },
        { x = -251, y = 2,   z = 380 },
        { x = -257, y = 4,   z = 381 },
        { x = -260, y = 5,   z = 386 },
        { x = -260, y = 7,   z = 396 },
        { x = -260, y = 8,   z = 402 },
        { x = -259, y = 10,  z = 411 },
        { x = -256, y = 12,  z = 417 },
        { x = -250, y = 13,  z = 419 },
        { x = -239, y = 16,  z = 420 }, --bottom of steps
        { x = -221, y = 16,  z = 420 },
        { x = -219, y = 16,  z = 457 },
        { x = -203, y = 16,  z = 460 },
        { x = -136, y = 16,  z = 458 },
        { x = -130, y = 16,  z = 456 },
        { x = -124, y = 16,  z = 446 },
        { x = -125, y = 16,  z = 389 },
        { x = -134, y = 16,  z = 380 },
        { x = -150, y = 16,  z = 379 },
        { x = -220, y = 16,  z = 379 },
        { x = -220, y = 16,  z = 416 },
        { x = -232, y = 16,  z = 419 },
        { x = -240, y = 16,  z = 419 }, -- bottom of steps going back upstairs
        { x = -255, y = 12,  z = 418 },
        { x = -260, y = 11,  z = 412 },
        { x = -260, y = 8,   z = 401 },
        { x = -259, y = 5,   z = 388 },
        { x = -255, y = 3,   z = 380 },
        { x = -239, y = 0,   z = 380 },
        { x = -215, y = 0,   z = 380 },
        { x = -204, y = 0,   z = 389 },
        { x = -197, y = 0,   z = 391 },
        { x = -186, y = 0,   z = 382 },
        { x = -177, y = 0,   z = 380 },
        { x = -162, y = 0,   z = 380 }, --first blue door
    },
    [paths.BLUE_TO_BLUE] =
    {
        -- Path from the First blue door to the middle blue door
        { x = -157, y = 0,   z = 380 },-- first blue door
        { x = -134, y = 0,   z = 380 },
        { x = -132, y = 0,   z = 382 },
        { x = -129, y = 0,   z = 385 },
        { x = -127, y = 0,   z = 393 },
        { x = -125, y = 0,   z = 404 },
        { x = -124, y = 0,   z = 413 },
        { x = -123, y = 0,   z = 423 },
        { x = -118, y = 0,   z = 436 },
        { x = -111, y = 0,   z = 452 },
        { x = -108, y = 0,   z = 458 },
        { x = -091, y = 0,   z = 460 },
        { x = -084, y = 0,   z = 460 },-- middle blue door
    },
    [paths.BLUE_TO_YELLOW] =
    {
        -- Path from the middle blue door to the middle yellow door
        { x = -76,  y = 0,   z = 459 },-- Middle blue door
        { x = -70,  y = 0,   z = 459 },
        { x = -62,  y = 0,   z = 455 },
        { x = -59,  y = 0,   z = 449 },
        { x = -60,  y = 0,   z = 433 },
        { x = -60,  y = 0,   z = 420 },
        { x = -50,  y = 0,   z = 420 },
        { x = -45,  y = 0,   z = 419 },
        { x = -18,  y = 0,   z = 420 },
        { x = 60,   y = 0,   z = 419 },
        { x = 60,   y = 0,   z = 450 },
        { x = 62,   y = 0,   z = 456 },
        { x = 67,   y = 0,   z = 459 },
        { x = 74,   y = 0,   z = 460 },
        { x = 78,   y = 0,   z = 460 },-- Middle yellow door
    },
    [paths.YELLOW_TO_YELLOW] =
    {
        -- Path from the middle yellow door to the first yellow door
        { x = 82,   y = 0,   z = 459 },-- Middle yellow door
        { x = 96,   y = 0,   z = 459 },
        { x = 103,  y = 0,   z = 459 },
        { x = 107,  y = 0,   z = 457 },
        { x = 112,  y = 0,   z = 452 },
        { x = 114,  y = 0,   z = 446 },
        { x = 116,  y = 0,   z = 437 },
        { x = 119,  y = 0,   z = 427 },
        { x = 120,  y = 0,   z = 418 },
        { x = 123,  y = 0,   z = 408 },
        { x = 128,  y = 0,   z = 388 },
        { x = 131,  y = 0,   z = 383 },
        { x = 135,  y = 0,   z = 380 },
        { x = 140,  y = 0,   z = 379 },
        { x = 147,  y = 0,   z = 379 },
        { x = 157,  y = 0,   z = 380 },-- first yellow door
    },
    [paths.YELLOW_TO_BASEMENT] =
    {
        -- Path from the first yellow door to the basement and back to the first yellow door
        { x = 185,  y = 0,   z = 380 }, --First Yellow door
        { x = 193,  y = 0,   z = 390 },
        { x = 191,  y = 0,   z = 402 },
        { x = 199,  y = 0,   z = 407 },
        { x = 207,  y = 0,   z = 408 },
        { x = 209,  y = 0,   z = 399 },
        { x = 206,  y = 0,   z = 390 },
        { x = 209,  y = 0,   z = 384 },
        { x = 216,  y = 0,   z = 380 },
        { x = 221,  y = 0,   z = 379 },
        { x = 239,  y = 0,   z = 379 },
        { x = 254,  y = 3,   z = 380 },
        { x = 259,  y = 4,   z = 384 }, -- Top of stairs
        { x = 259,  y = 11,  z = 415 },
        { x = 254,  y = 12,  z = 419 },
        { x = 219,  y = 16,  z = 420 },
        { x = 219,  y = 16,  z = 387 },
        { x = 215,  y = 16,  z = 380 },
        { x = 211,  y = 16,  z = 380 },
        { x = 142,  y = 16,  z = 380 },
        { x = 139,  y = 16,  z = 384 },
        { x = 139,  y = 16,  z = 419 },
        { x = 145,  y = 16,  z = 427 },
        { x = 173,  y = 16,  z = 458 },
        { x = 178,  y = 16,  z = 460 },
        { x = 210,  y = 16,  z = 460 },
        { x = 215,  y = 16,  z = 457 },
        { x = 219,  y = 16,  z = 452 },
        { x = 219,  y = 16,  z = 442 },
        { x = 219,  y = 16,  z = 420 },
        { x = 240,  y = 16,  z = 419 },
        { x = 258,  y = 12,  z = 417 },
        { x = 259,  y = 4,   z = 384 },
        { x = 254,  y = 3,   z = 380 },
        { x = 239,  y = 0,   z = 379 },
        { x = 214,  y = 0,   z = 380 },
        { x = 208,  y = 0,   z = 386 },
        { x = 208,  y = 0,   z = 398 },
        { x = 206,  y = 0,   z = 405 },
        { x = 198,  y = 0,   z = 409 },
        { x = 191,  y = 0,   z = 405 },
        { x = 192,  y = 0,   z = 395 },
        { x = 193,  y = 0,   z = 389 },
        { x = 187,  y = 0,   z = 382 },
        { x = 184,  y = 0,   z = 380 },
        { x = 164,  y = 0,   z = 380 },
    },
    [paths.BLUE_SPAWN_SHORT] =
    {
        -- From blue side spawn point to the first blue door
        { x = -195, y = 0,   z = 395 },
        { x = -192, y = 0,   z = 390 },
        { x = -189, y = 0,   z = 384 },
        { x = -183, y = 0,   z = 380 },
        { x = -165, y = 0,   z = 380 },
        { x = -162, y = 0,   z = 380 },
    },
    [paths.BLUE_SPAWN_LONG] =
    {
        -- From the blue side basement to the first blue door
        { x = -134, y = 16,  z = 380 },
        { x = -150, y = 16,  z = 379 },
        { x = -220, y = 16,  z = 379 },
        { x = -220, y = 16,  z = 416 },
        { x = -232, y = 16,  z = 419 },
        { x = -240, y = 16,  z = 419 }, -- bottom of steps going back upstairs
        { x = -255, y = 12,  z = 418 },
        { x = -260, y = 11,  z = 412 },
        { x = -260, y = 8,   z = 401 },
        { x = -259, y = 5,   z = 388 },
        { x = -255, y = 3,   z = 380 },
        { x = -239, y = 0,   z = 380 },
        { x = -215, y = 0,   z = 380 },
        { x = -204, y = 0,   z = 389 },
        { x = -197, y = 0,   z = 391 },
        { x = -186, y = 0,   z = 382 },
        { x = -177, y = 0,   z = 380 },
        { x = -162, y = 0,   z = 380 }, --first blue door
    },
    [paths.YELLOW_SPAWN_SHORT] =
    {
        -- From the short yellow side spawn point to the first yellow door
        { x = 191,  y = 0,   z = 399 },
        { x = 192,  y = 0,   z = 389 },
        { x = 186,  y = 0,   z = 381 },
        { x = 182,  y = 0,   z = 379 },
        { x = 174,  y = 0,   z = 379 },
        { x = 161,  y = 0,   z = 379 },
    },
    [paths.YELLOW_SPAWN_LONG] =
    {
        -- From the yellow basement to the first yellow door
        { x = 173,  y = 16,  z = 458 },
        { x = 178,  y = 16,  z = 460 },
        { x = 210,  y = 16,  z = 460 },
        { x = 215,  y = 16,  z = 457 },
        { x = 219,  y = 16,  z = 452 },
        { x = 219,  y = 16,  z = 442 },
        { x = 219,  y = 16,  z = 420 },
        { x = 240,  y = 16,  z = 419 },
        { x = 258,  y = 12,  z = 417 },
        { x = 259,  y = 4,   z = 384 },
        { x = 254,  y = 3,   z = 380 },
        { x = 239,  y = 0,   z = 379 },
        { x = 214,  y = 0,   z = 380 },
        { x = 208,  y = 0,   z = 386 },
        { x = 208,  y = 0,   z = 398 },
        { x = 206,  y = 0,   z = 405 },
        { x = 198,  y = 0,   z = 409 },
        { x = 191,  y = 0,   z = 405 },
        { x = 192,  y = 0,   z = 395 },
        { x = 193,  y = 0,   z = 389 },
        { x = 187,  y = 0,   z = 382 },
        { x = 184,  y = 0,   z = 380 },
        { x = 176,  y = 0,   z = 379 },
        { x = 157,  y = 0,   z = 380 },
    },
}

local setZipPath = function(mob, door, currPath)
    if door then
        if door:getAnimation() == xi.anim.OPEN_DOOR then
            if currentDirection == pathingDirection.TO_EAST then
                mob:pathThrough(pathNodes[currPath + 1], xi.path.flag.COORDS)
                if currPath + 1 == paths.YELLOW_TO_BASEMENT then
                    currentDirection = pathingDirection.TO_WEST
                end
            else -- East to West
                mob:pathThrough(pathNodes[currPath], bit.bor(xi.path.flag.COORDS, xi.path.flag.REVERSE))
                if currPath == paths.BLUE_TO_BASEMENT then
                    currentDirection = pathingDirection.TO_EAST
                end
            end
        else -- Door was closed
            if currentDirection == pathingDirection.TO_EAST then
                mob:pathThrough(pathNodes[currPath], bit.bor(xi.path.flag.COORDS, xi.path.flag.REVERSE))
                if currPath ~= paths.BLUE_TO_BASEMENT then
                    currentDirection = pathingDirection.TO_WEST
                end
            else -- East to West
                mob:pathThrough(pathNodes[currPath + 1], xi.path.flag.COORDS)
                if currPath + 1 ~= paths.YELLOW_TO_BASEMENT then
                    currentDirection = pathingDirection.TO_EAST
                end
            end
        end
    end
end

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.REGAIN, 200)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobSpawn = function(mob)
    -- Check distance on each of the spawn points to find start point
    if mob:checkDistance(spawnPoints.blueShort) <= 10 then
        currentDirection = pathingDirection.TO_EAST
        mob:pathThrough(pathNodes[paths.BLUE_SPAWN_SHORT], xi.path.flag.COORDS)

    elseif mob:checkDistance(spawnPoints.blueLong) <= 10 then
        currentDirection = pathingDirection.TO_EAST
        mob:pathThrough(pathNodes[paths.BLUE_SPAWN_LONG], xi.path.flag.COORDS)

    elseif mob:checkDistance(spawnPoints.yellowShort) <= 10 then
        currentDirection = pathingDirection.TO_WEST
        mob:pathThrough(pathNodes[paths.YELLOW_SPAWN_SHORT], xi.path.flag.COORDS)

    elseif mob:checkDistance(spawnPoints.yellowLong) <= 10 then
        currentDirection = pathingDirection.TO_WEST
        mob:pathThrough(pathNodes[paths.YELLOW_SPAWN_LONG], xi.path.flag.COORDS)
    end
end

entity.onMobMobskillChoose = function(mob, target)
    -- Zipacna heavily prefers using Crystal Rain and Crystal Weapon
    local roll = math.random(1, 100)

    if roll <= 30 then
        return xi.mobSkill.CRYSTAL_RAIN
    elseif roll <= 60 then
        local weaponEle = math.random(xi.mobSkill.CRYSTAL_WEAPON_FIRE, xi.mobSkill.CRYSTAL_WEAPON_WATER)
        return weaponEle
    end
end

entity.onMobRoam = function(mob)
    local firstBlueDoor    = GetNPCByID(ID.npc.B_DOOR_OFFSET + 1) -- North-West Blue Door _4x9
    local middleBlueDoor   = GetNPCByID(ID.npc.B_DOOR_OFFSET)     -- North-Central Blue Door _4x8
    local firstYellowDoor  = GetNPCByID(ID.npc.Y_DOOR_OFFSET + 6) -- North-East Yellow Door _4x6
    local middleYellowDoor = GetNPCByID(ID.npc.Y_DOOR_OFFSET + 7) -- North-Central Yellow Door _4x7

    -- check that we got all door objects (and for CI sake)
    if
        not firstBlueDoor or
        not middleBlueDoor or
        not firstYellowDoor or
        not middleYellowDoor
    then
        return
    end

    if mob:checkDistance(firstBlueDoor:getPos()) <= 7 then
        setZipPath(mob, firstBlueDoor, 1)
    elseif mob:checkDistance(middleBlueDoor:getPos()) <= 7 then
        setZipPath(mob, middleBlueDoor, 2)
    elseif mob:checkDistance(middleYellowDoor:getPos()) <= 7 then
        setZipPath(mob, middleYellowDoor, 3)
    elseif mob:checkDistance(firstYellowDoor:getPos()) <= 7 then
        setZipPath(mob, firstYellowDoor, 4)
    end
end

entity.onMobDisengage = function(mob)
    -- Resume pathing based on current direction and nearest checkpoint
    local mobPos = mob:getPos()

    -- Determine if we're closer to blue or yellow side
    if mobPos.x < 0 then
        -- Blue (west) side
        if currentDirection == pathingDirection.TO_EAST then
            mob:pathThrough(pathNodes[paths.BLUE_TO_BLUE], xi.path.flag.COORDS)
        else
            mob:pathThrough(pathNodes[paths.BLUE_TO_BASEMENT], bit.bor(xi.path.flag.COORDS, xi.path.flag.REVERSE))
        end
    else
        -- Yellow (east) side
        if currentDirection == pathingDirection.TO_EAST then
            mob:pathThrough(pathNodes[paths.YELLOW_TO_BASEMENT], xi.path.flag.COORDS)
        else
            mob:pathThrough(pathNodes[paths.YELLOW_TO_YELLOW], bit.bor(xi.path.flag.COORDS, xi.path.flag.REVERSE))
        end
    end
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(10800, 14400)) -- respawn 3-4 hrs
end

return entity
