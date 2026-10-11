-----------------------------------
-- Area: Xarcabard
--  Mob: Lost Soul
-- Note: PH for Timeworn Warrior
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 51, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 52, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 53, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 54, 3, xi.regime.type.FIELDS)
end

return entity
