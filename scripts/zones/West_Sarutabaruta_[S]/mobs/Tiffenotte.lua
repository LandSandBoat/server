-----------------------------------
-- Area: West Sarutabaruta [S]
--   NM: Tiffenotte
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 520)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(7200, 8400)) -- 2 hours to 2 hours, 20 minutes
end

return entity
