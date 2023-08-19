-----------------------------------
-- Area: Zeruhn Mines (172)
--  Mob: Colliery Bat
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 628, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 629, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 630, 1, xi.regime.type.GROUNDS)
end

return entity
