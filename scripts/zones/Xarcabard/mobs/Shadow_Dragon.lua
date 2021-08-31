-----------------------------------
-- Area: Xarcabard
--  Mob: Shadow Dragon
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    local B_ToD = GetServerVariable("[POP]Biast")
    local X = mob:getXPos()
    local Y = mob:getYPos()
    local Z = mob:getZPos()

    -- Check if Biast window is open, and there is not an Biast popped already
    if B_ToD <= os.time() and not GetMobByID(mob:getID() + 1):isSpawned() then
        if math.random(1, 20) == 5 then
            SpawnMob(mob:getID() + 1)
            GetMobByID(mob:getID() + 1):setPos(X, Y, Z)
            GetMobByID(mob:getID() + 1):setSpawn(X, Y, Z)
            DisallowRespawn(mob:getID(), true)
        end
    end
end

return entity
