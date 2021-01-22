-----------------------------------
-- Area: The Eldieme Necropolis [S]
--   NM: Ethniu
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 497)
end

return entity
