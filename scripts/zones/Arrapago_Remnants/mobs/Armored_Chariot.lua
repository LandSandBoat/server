-----------------------------------
-- Area: Arrapago Remnants
--   NM: Armored Chariot
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.SUN_CHARIOTEER)
end

return entity
