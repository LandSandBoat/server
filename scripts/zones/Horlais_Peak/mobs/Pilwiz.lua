-----------------------------------
-- Area: Horlais Peak
--  Mob: Pilwiz
-- BCNM: Carapace Combatants
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
