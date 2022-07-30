-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Memory Receptacles (Blue Model)
-----------------------------------
local ID = require("scripts/zones/Spire_of_Vahzl/IDs")
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local positions =
{
    [1] =
    {
        { x = -230.69, y = 60.75, z =  -0.36 }, -- W
        { x = -239.83, y = 60.75, z =   9.62 }, -- S
        { x = -249.41, y = 60.75, z =   0.07 }, -- E
        { x = -240.02, y = 60.75, z =  -9.15 }, -- N
        { x = -255.24, y = 60.00, z =   0.02 }, -- EE
        { x = -255.24, y = 60.00, z =   0.02 }, -- EE
        { x = -224.92, y = 60.00, z =  -0.09 }, -- WW
        { x = -240.32, y = 60.00, z = -14.79 }, -- NN
    },
    [2] =
    {
        { x =   10.69, y = 0.75, z =  -0.36 }, -- W
        { x =   1.835, y = 0.75, z =   9.62 }, -- S
        { x =   -9.41, y = 0.75, z =  0.078 }, -- E
        { x =   0.022, y = 0.75, z =  -9.15 }, -- N
        { x =    0.32, y = 0.00, z = -14.79 }, -- EE
        { x =    0.32, y = 0.00, z = -14.79 }, -- EE
        { x =  16.921, y = 0.00, z = -0.095 }, -- WW
        { x = -15.249, y = 0.00, z =  0.028 }, -- NN
    },
    [3] =
    {
        { x =  250.69, y = -59.75, z =  -0.36 }, -- W
        { x = 241.835, y = -59.75, z =   9.62 }, -- S
        { x =  231.41, y = -59.75, z =  0.078 }, -- E
        { x = 240.022, y = -59.75, z =  -9.15 }, -- N
        { x =  240.32, y = -60.00, z = -14.79 }, -- EE
        { x =  240.32, y = -60.00, z = -14.79 }, -- EE
        { x = 256.921, y = -60.00, z = -0.095 }, -- WW
        { x = 225.249, y = -60.00, z =  0.028 }, -- NN
    }
}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)

    -- Give orbs a random spawn location
    local battlefield = mob:getBattlefield()
    local bfID = battlefield:getArea()
    local posNum = GetMobByID(ID.pullingThePlug[bfID].RED_ID):getLocalVar("positionNum")
    local posSet = positions[bfID]
    for k, pos in pairs(posSet) do
        if k == posNum then
            mob:setPos(pos.x, pos.y, pos.z)
            break
        end
    end
end

entity.onMobFight = function(mob, target)
    -- Orbs move every 30 seconds
    local battlefield = mob:getBattlefield()
    local posNum = GetMobByID(ID.pullingThePlug[battlefield:getArea()].RED_ID):getLocalVar("positionNum")
    local posSet = positions[battlefield:getArea()]
    local moveX = 0
    local moveY = 0
    local moveZ = 0

    -- Get new positions
    for k, pos in pairs(posSet) do
        if k == posNum then
            moveX = pos.x
            moveY = pos.y
            moveZ = pos.z
            break
        end
    end

    local distance = mob:checkDistance(moveX, moveY, moveZ)
    if distance > 1 then
        mob:setLocalVar("moving", 1)
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        mob:pathTo(moveX, moveY, moveZ)
    else
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        mob:setLocalVar("moving", 0)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    -- Spawn mob from body and let main receptacle know you died
    local bfID = mob:getBattlefield():getArea()
    local pos = mob:getPos()
    local repiner = GetMobByID(ID.pullingThePlug[bfID].REPINER)
    repiner:setSpawn(pos.x, pos.y, pos.z, pos.rot)
    repiner:spawn()

    mob:getBattlefield():setLocalVar("BlueDead", 1)
end

entity.onMobDespawn = function(mob)
    mob:resetLocalVars()
end

return entity
