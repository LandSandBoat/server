-----------------------------------
-- Area: Beadeaux (254)
--   NM: Zo'Khu Blackcloud
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/hunts")
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 242)
    xi.roe.onRecordTrigger(player, 263)
end

return entity
