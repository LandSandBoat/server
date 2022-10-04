-----------------------------------
-- Area: Beadeaux (254)
--   NM: Zo'Khu Blackcloud
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 242)
end

return entity
