-----------------------------------
-- Area: Crawlers Nest [S]
--   NM: Abatwa
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 514)
end

return entity
