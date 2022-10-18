-----------------------------------
-- Area: Pashhow Marshlands [S]
--   NM: Kinepikwa
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 507)
end

return entity
