-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Goblin Leecher
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 631, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 635, 2, xi.regime.type.GROUNDS)
end

return entity
