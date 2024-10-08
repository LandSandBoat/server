-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Kirin's Avatar
-----------------------------------
---@type TMobEntity
local entity = {}

mixins = { require('scripts/mixins/families/avatar') }

entity.onMobDeath = function(mob, player, optParams)
end

return entity
