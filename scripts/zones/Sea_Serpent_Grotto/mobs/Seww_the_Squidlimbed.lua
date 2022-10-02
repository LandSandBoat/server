-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Seww the Squidlimbed
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 374)
end

return entity
