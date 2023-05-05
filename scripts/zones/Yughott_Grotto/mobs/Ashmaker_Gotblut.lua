-----------------------------------
-- Area: Yughott Grotto (142)
--   NM: Ashmaker Gotblut
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.roe.onRecordTrigger(player, 224)
end

return entity
