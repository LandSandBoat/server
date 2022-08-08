-----------------------------------
-- Area: Ve'Lugannon Palace
--   NM: Steam Cleaner
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 120)
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobRoam = function(mob)
    local spawner = GetMobByID(mob:getLocalVar("spawner"))
    if spawner:isAlive() then
        mob:pathTo(spawner:getXPos() + 1, spawner:getYPos() + 3, spawner:getZPos() + 0.15)
    end
end

entity.onMobDespawn = function(mob)
    SetServerVariable("[POP]SteamCleaner", os.time() + math.random(7200, 14400))
end

return entity
