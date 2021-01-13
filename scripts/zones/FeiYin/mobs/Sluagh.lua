-----------------------------------
-- Area: FeiYin
--   NM: Sluagh
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 349)
end

return entity
