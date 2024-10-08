-----------------------------------
-- Area: Mount Zhayolm
--  MOB: Zhayolm Apkallu
-----------------------------------
mixins = { require('scripts/mixins/families/apkallu') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
