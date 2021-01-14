-----------------------------------
-- Area: Gusgen Mines
--   NM: Pulverized Pfeffer
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 232)
end

return entity
