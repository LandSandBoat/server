-----------------------------------
-- Area: Qufim Island
--   NM: Trickster Kinetix
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 307)
end

return entity
