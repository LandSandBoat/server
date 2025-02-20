-----------------------------------
-- Area: Zhayolm Remnants
-- MOB: Rogue Marid
-- Notes: Rampart Pet
-----------------------------------
mixins = { require('scripts/mixins/families/marid') }
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
