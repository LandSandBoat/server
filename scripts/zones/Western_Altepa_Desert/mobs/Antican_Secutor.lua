-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Antican Secutor
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 138, 1, xi.regime.type.FIELDS)
end

return entity
