-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Spartoi Sorcerer
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 638, 1, xi.regime.type.GROUNDS)
end

return entity
