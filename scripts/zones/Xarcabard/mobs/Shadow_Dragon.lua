-----------------------------------
-- Area: Xarcabard
--  Mob: Shadow Dragon
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 1000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 3000)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local biastTimeOfDeath = GetServerVariable('[POP]Biast')
    local xPos = mob:getXPos()
    local yPos = mob:getYPos()
    local zPos = mob:getZPos()

    -- Check if Biast window is open, and there is not an Biast popped already
    if
        biastTimeOfDeath <= os.time() and
        not GetMobByID(mob:getID() + 1):isSpawned()
    then
        if math.random(1, 20) == 5 then
            SpawnMob(mob:getID() + 1)
            GetMobByID(mob:getID() + 1):setPos(xPos, yPos, zPos)
            GetMobByID(mob:getID() + 1):setSpawn(xPos, yPos, zPos)
            DisallowRespawn(mob:getID(), true)
        end
    end
end

return entity
