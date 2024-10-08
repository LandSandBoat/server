-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Witch Hazel
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 689, 2, xi.regime.type.GROUNDS)
end

return entity
