-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Fyuu the Seabellow
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 372)
end

return entity
