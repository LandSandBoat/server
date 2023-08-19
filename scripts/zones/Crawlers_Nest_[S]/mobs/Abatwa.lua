-----------------------------------
-- Area: Crawlers Nest [S]
--   NM: Abatwa
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 514)
end

return entity
