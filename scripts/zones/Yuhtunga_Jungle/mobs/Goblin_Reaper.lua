-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Goblin Reaper
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 125, 2, xi.regime.type.FIELDS)
end

return entity
