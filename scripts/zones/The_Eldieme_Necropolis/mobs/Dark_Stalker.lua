-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Dark Stalker
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 672, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 673, 1, xi.regime.type.GROUNDS)
end

return entity
