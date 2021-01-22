-----------------------------------
-- Area: Gusgen Mines
--   NM: Smothered Schmidt
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 230)
end

return entity
