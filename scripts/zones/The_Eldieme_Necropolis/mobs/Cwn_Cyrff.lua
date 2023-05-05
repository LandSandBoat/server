-----------------------------------
-- Area: The Eldieme Necropolis
--   NM: Cwn Cyrff
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 191)
    xi.roe.onRecordTrigger(player, 244)
end

return entity
