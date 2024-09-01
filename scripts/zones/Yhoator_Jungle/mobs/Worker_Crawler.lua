-----------------------------------
-- Area: Yhoator Jungle
--  Mob: Worker Crawler
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 132, 1, xi.regime.type.FIELDS)
end

return entity
