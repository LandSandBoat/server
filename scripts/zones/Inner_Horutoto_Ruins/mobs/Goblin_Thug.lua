-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Goblin Thug
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 647, 2, xi.regime.type.GROUNDS)
end

return entity
