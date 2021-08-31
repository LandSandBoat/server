-----------------------------------
-- Area: Gusgen Mines
--   NM: Wounded Wurfel
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 234)
end

return entity
