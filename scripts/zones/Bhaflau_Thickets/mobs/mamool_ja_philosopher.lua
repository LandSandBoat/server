-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Mamool Ja Philosopher
-----------------------------------
mixins = { require('scripts/mixins/families/mamool_ja'), require('scripts/mixins/weapon_break') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
