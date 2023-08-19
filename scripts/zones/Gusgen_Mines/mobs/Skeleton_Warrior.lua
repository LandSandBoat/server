-----------------------------------
-- Area: Gusgen Mines
--  Mob: Skeleton Warrior
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 679, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 680, 2, xi.regime.type.GROUNDS)
end

return entity
