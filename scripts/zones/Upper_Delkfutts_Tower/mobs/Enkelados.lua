-----------------------------------
-- Area: Upper Delkfutt's Tower
--   NM: Enkelados
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 331)
    xi.roe.onRecordTrigger(player, 309)
end

return entity
