-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Labyrinth Leech
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 771, 1, xi.regime.type.GROUNDS)
end

return entity
