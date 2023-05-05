-----------------------------------
-- Area: Davoi
--   NM: Hawkeyed Dnatbat
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 192)
    xi.roe.onRecordTrigger(player, 246)
end

return entity
