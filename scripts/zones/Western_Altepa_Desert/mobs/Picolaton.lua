-----------------------------------
-- Area: Western Altepa Desert
--   NM: Picolaton
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 414)
end

return entity
