-----------------------------------
-- Area: Buburimu Peninsula (118)
--  Mob: Helldiver
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 262)
    xi.roe.onRecordTrigger(player, 277)
end

return entity
