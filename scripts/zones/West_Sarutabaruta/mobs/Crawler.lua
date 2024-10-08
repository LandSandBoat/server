-----------------------------------
-- Area: West Sarutabaruta
--  Mob: Crawler
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 28, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 29, 2, xi.regime.type.FIELDS)
end

return entity
