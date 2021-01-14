-----------------------------------
-- Area: Caedarva Mire
--   NM: Khimaira
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(tpz.title.KHIMAIRA_CARVER)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(48, 72) * 3600) -- 48 to 72 hours, in 1-hour increments
end

return entity
