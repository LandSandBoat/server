-----------------------------------
-- Area: Lower Delkfutt's Tower
--   NM: Epialtes
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 340)
    xi.roe.onRecordTrigger(player, 305)
end

return entity
