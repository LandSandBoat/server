-----------------------------------
-- Area: Silver Sea Remnants
--   NM: Long-Armed Chariot
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(tpz.title.MOON_CHARIOTEER)
end

return entity
