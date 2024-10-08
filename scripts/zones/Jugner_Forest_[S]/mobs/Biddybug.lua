-----------------------------------
-- Area: Jugner Forest [S]
--  Mob: Biddybug
-----------------------------------
mixins = { require('scripts/mixins/families/ladybug') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
