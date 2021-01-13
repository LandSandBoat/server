-----------------------------------
-- Area: Zhayolm Remnants
--   NM: Battleclad Chariot
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(tpz.title.STAR_CHARIOTEER)
end

return entity
