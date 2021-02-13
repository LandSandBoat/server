-----------------------------------
-- Area: Misareaux Coast
--   NM: Odqan
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 443)
end

return entity
