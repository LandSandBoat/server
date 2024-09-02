-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Qutrub
-----------------------------------
mixins = { require('scripts/mixins/families/qutrub') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
