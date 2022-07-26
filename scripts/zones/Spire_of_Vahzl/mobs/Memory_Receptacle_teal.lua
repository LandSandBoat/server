-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Memory Receptacles (Teal Model)
-----------------------------------
local ID = require("scripts/zones/Spire_of_Vahzl/IDs")
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local positions =
{
    [1] =
    {
        { x =  -230.65, y = 60.75, z =   9.29 }, -- SW
        { x =  -249.31, y = 60.75, z =  10.03 }, -- SE
        { x =  -249.45, y = 60.75, z =  -8.71 }, -- NE
        { x = -230.980, y = 60.75, z =  -8.65 }, -- NW
        { x =  -240.32, y = 60.00, z = -14.79 }, -- NN
        { x = -224.921, y = 60.00, z = -0.095 }, -- WW
        { x =  -240.32, y = 60.00, z = -14.79 }, -- NN
        { x = -255.249, y = 60.00, z =  0.028 }, -- EE
    },
    [2] =
    {
        { x =   10.65, y = 0.75, z =   9.29 }, -- SW
        { x =   -9.31, y = 0.75, z =  10.03 }, -- SE
        { x =   -9.45, y = 0.75, z =  -8.71 }, -- NE
        { x =  10.980, y = 0.75, z =  -8.65 }, -- NW
        { x = -15.249, y = 0.00, z =  0.028 }, -- NN
        { x =  16.921, y = 0.00, z = -0.095 }, -- WW
        { x = -15.249, y = 0.00, z =  0.028 }, -- NN
        { x =    0.32, y = 0.00, z = -14.79 }, -- EE
    },
    [3] =
    {
        { x =  250.65, y = -59.75, z =   9.29 }, -- SW
        { x =  231.31, y = -59.75, z =  10.03 }, -- SE
        { x =  231.45, y = -59.75, z =  -8.71 }, -- NE
        { x = 250.980, y = -59.75, z =  -8.65 }, -- NW
        { x = 225.249, y = -60.00, z =  0.028 }, -- NN
        { x = 256.921, y = -60.00, z = -0.095 }, -- WW
        { x = 225.249, y = -60.00, z =  0.028 }, -- NN
        { x =  240.32, y = -60.00, z = -14.79 }, -- EE
    }
}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)

    -- Give orbs a random spawn location
    local battlefield = mob:getBattlefield()
    local bfID = battlefield:getArea()
    local posNum = GetMobByID(ID.pullingThePlug[battlefield:getArea()].RED_ID):getLocalVar("positionNum")
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
    local contemplator = GetMobByID(ID.pullingThePlug[bfID].CONTEMPLATOR)
    contemplator:setSpawn(pos.x, pos.y, pos.z, pos.rot)
    contemplator:spawn()

    mob:getBattlefield():setLocalVar("TealDead", 1)
end

entity.onMobDespawn = function(mob)
    mob:resetLocalVars()
end

return entity
