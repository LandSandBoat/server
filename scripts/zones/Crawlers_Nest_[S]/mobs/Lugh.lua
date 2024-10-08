-----------------------------------
-- Area: Crawlers Nest [S]
--   NM: Lugh
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 516)
end

return entity
