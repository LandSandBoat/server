-----------------------------------
-- Area: Qufim Island
--   NM: Trickster Kinetix
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 307)
end

return entity
