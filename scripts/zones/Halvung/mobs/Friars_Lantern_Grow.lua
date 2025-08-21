-----------------------------------
-- Area: Halvung
--  Mob: Friar's Lantern (Growing Version)
-----------------------------------
mixins = { require('scripts/mixins/families/bomb_grow') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
