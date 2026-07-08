-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Hornfly
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 690, 2, xi.regime.type.GROUNDS)
end

return entity
