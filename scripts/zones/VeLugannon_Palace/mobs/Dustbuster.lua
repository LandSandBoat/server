-----------------------------------
-- Area: Ve'Lugannon Palace
--  Mob: Dustbuster
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 743, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 745, 1, xi.regime.type.GROUNDS)
end

return entity
