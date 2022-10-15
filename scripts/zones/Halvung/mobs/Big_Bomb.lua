-----------------------------------
-- Area: Halvung
--   NM: Big Bomb
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 466)
end

return entity
