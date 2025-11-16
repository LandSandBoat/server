-----------------------------------
-- Area: Horlais Peak
--  Mob: Bisan
-- BCNM: Carapace Combatants
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.SILENCE_MEVA, 75)
    mob:setMod(xi.mod.SLEEP_MEVA, 50)
end

return entity
