-----------------------------------
-- Area: South Gustaberg
--   NM: Bubbly Bernie
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 80, 2, xi.regime.type.FIELDS)
end

return entity
