-----------------------------------
-- Area: Gusgen Mines
--  Mob: Foul Meat
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(64800, 86400)) -- 18 to 24 hours
end

return entity
