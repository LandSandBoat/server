-----------------------------------
-- Area: The Sanctuary of ZiTah
--  Mob: Master Coeurl
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 117, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 118, 2, xi.regime.type.FIELDS)
end

return entity
