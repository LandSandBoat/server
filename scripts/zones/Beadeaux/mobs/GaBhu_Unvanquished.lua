-----------------------------------
-- Area: Beadeaux (254)
--   NM: Ga'Bhu Unvanquished
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 243)
end

return entity
