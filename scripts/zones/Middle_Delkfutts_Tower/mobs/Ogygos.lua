-----------------------------------
-- Area: Middle Delkfutt's Tower
--   NM: Ogygos
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 339)
    xi.roe.onRecordTrigger(player, 307)
end

return entity
