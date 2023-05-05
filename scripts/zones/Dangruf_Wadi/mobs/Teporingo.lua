-----------------------------------
-- Area: Dangruf Wadi
--   NM: Teporingo
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 223)
    xi.roe.onRecordTrigger(player, 255)
end

return entity
