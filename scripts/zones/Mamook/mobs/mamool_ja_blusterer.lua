-----------------------------------
-- Area: Mamook
--  Mob: Mamool Ja Blusterer
-----------------------------------
mixins = { require('scripts/mixins/families/mamool_ja'), require('scripts/mixins/weapon_break') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
