-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Voll the Sharkfinned
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 378)
end

return entity
