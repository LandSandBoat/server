-----------------------------------
-- Area: Gusgen Mines
--   NM: Crushed Krause
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 231)
end

return entity
