-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Worr the Clawfisted
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 381)
end

return entity
