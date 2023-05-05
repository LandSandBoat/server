-----------------------------------
-- Area: North Gustaberg
--   NM: Maighdean Uaine
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 198)
    xi.roe.onRecordTrigger(player, 248)
end

return entity
