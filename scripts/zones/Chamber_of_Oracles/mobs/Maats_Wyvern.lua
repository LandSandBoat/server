-----------------------------------
-- Area: Chamber of Oracles
--  Mob: Maat's Wyvern
-- Genkai 5 Fight
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.combat.behavior.enableAllActions(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

return entity
