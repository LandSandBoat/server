-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Denn the Orcavoiced
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 379)
end

return entity
