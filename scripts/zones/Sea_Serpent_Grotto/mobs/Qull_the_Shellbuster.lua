-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Qull the Shellbuster
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 373)
end

return entity
