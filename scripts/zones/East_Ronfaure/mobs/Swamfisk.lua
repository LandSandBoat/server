-----------------------------------
-- Area: East Ronfaure
--   NM: Swamfisk
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 150)
    xi.roe.onRecordTrigger(player, 218)
end

return entity
