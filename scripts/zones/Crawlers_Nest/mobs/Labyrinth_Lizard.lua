-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Labyrinth Lizard
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 689, 1, xi.regime.type.GROUNDS)
end

return entity
