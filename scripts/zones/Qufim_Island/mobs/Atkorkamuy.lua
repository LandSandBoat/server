-----------------------------------
-- Area: Qufim Island
--  Mob: Atkorkamuy
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 310)
end

return entity
