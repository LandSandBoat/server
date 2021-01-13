-----------------------------------
-- Area: Gusgen Mines
--  Mob: Foul Meat
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(64800, 86400)) -- 18 to 24 hours
end

return entity
