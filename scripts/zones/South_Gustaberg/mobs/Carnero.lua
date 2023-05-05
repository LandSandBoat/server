-----------------------------------
-- Area: South Gustaberg
--   NM: Carnero
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 202)
    xi.roe.onRecordTrigger(player, 250)
end

return entity
