-----------------------------------
-- Area: La Theine Plateau
--  Mob: Akbaba
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DETECTION, xi.detects.HEARING)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 69, 2, xi.regime.type.FIELDS)
end

return entity
