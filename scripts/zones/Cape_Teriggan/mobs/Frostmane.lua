-----------------------------------
-- Area: Cape Teriggan
--   NM: Frostmane
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 405)
end

return entity
