-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Will-o-the-Wisp
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 657, 2, xi.regime.type.GROUNDS)
end

return entity
