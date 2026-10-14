-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Moss Eater
-- Note: PH for Unut
-- TODO: 3 PHs should be in a spawning group that only one of them can be up at a time
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 721, 2, xi.regime.type.GROUNDS)
end

return entity
