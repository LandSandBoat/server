-----------------------------------
-- Area: Halvung
--   NM: Big Bomb
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 466)
end

return entity
