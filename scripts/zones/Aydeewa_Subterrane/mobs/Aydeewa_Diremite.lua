-----------------------------------
-- Area: Aydeewa Subterrane
--  Mob: Aydeewa Diremite
-----------------------------------
mixins = { require('scripts/mixins/families/chigoe_pet') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
