-----------------------------------
-- Area: West Sarutabaruta
--  Mob: Bumblebee
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 61, 2, xi.regime.type.FIELDS)
end

return entity
