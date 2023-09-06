-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Pahh the Gullcaller
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 375)
end

return entity
