-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Osschaart's Avatar
-- KSNM30 Copycat
-----------------------------------
---@type TMobEntity
local entity = {}

mixins = { require('scripts/mixins/families/avatar') }

entity.onMobDeath = function(mob, player, optParams)
end

return entity
