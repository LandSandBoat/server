-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Moo Ouzi the Swiftblade
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 303)
end

return entity
