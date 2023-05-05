-----------------------------------
-- Area: East Sarutabaruta
--   NM: Spiny Spipi
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 253)
    xi.roe.onRecordTrigger(player, 267)
end

return entity
