-----------------------------------
-- Area: Sacrificial Chamber
--  Mob: Hyohh the Conchblower
-- BCNM: Amphibian Assault
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
