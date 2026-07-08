-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Lich
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 619, 2, xi.regime.type.GROUNDS)
end

return entity
