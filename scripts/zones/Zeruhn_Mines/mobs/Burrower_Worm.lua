-----------------------------------
-- Area: Zeruhn Mines (172)
--  Mob: Burrower Worm
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 629, 2, xi.regime.type.GROUNDS)
end

return entity
