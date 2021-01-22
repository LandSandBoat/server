-----------------------------------
-- Area: The Boyahda Tree
--   NM: Ellyllon
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 357)
end

return entity
