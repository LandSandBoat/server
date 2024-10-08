-----------------------------------
-- Area: La Vaule [S]
--  Mob: Mariehene
-----------------------------------
mixins = { require('scripts/mixins/families/ladybug') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
