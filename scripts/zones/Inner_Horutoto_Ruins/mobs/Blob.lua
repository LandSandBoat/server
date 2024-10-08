-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Blob
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 649, 2, xi.regime.type.GROUNDS)
end

return entity
