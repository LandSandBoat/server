-----------------------------------
-- Area: Apollyon CS
--  Mob: Grognard Footsoldier
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
