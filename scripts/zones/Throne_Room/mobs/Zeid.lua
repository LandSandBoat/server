-----------------------------------
-- Area: Throne Room
--  Mob: Zeid (Phase 1)
-- Bastok mission 9-2 BCNM Fight (Phase 1)
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addMod(xi.mod.REGAIN, 200)
end

return entity
