-----------------------------------
-- Area: Zeruhn Mines (172)
--  Mob: Ding Bats
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 626, 1, xi.regime.type.GROUNDS)
end

return entity
