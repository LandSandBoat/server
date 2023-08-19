-----------------------------------
-- Area: Gusgen Mines
--  Mob: Fly Agaric
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 680, 1, xi.regime.type.GROUNDS)
end

return entity
