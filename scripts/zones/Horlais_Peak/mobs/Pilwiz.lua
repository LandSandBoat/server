-----------------------------------
-- Area: Horlais Peak
--  Mob: Pilwiz
-- BCNM: Carapace Combatants
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.UFASTCAST, 150)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
