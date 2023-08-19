-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Will-o-the-Wisp
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 650, 2, xi.regime.type.GROUNDS)
end

return entity
