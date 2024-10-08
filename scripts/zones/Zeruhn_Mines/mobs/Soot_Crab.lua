-----------------------------------
-- Area: Zeruhn Mines (172)
--  Mob: Soot Crab
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 628, 2, xi.regime.type.GROUNDS)
end

return entity
