-----------------------------------
-- Area: Jugner Forest [S]
--  Mob: Decrepit Gnole
-----------------------------------
mixins = { require('scripts/mixins/families/gnole') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
