-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Tomb Mage
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 671, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 675, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 676, 2, xi.regime.type.GROUNDS)
end

return entity
