-----------------------------------
-- Area: Zeruhn Mines (172)
--  Mob: River Crab
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 627, 1, xi.regime.type.GROUNDS)
end

return entity
