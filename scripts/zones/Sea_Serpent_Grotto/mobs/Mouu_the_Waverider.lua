-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Mouu the Waverider
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 380)
end

return entity
