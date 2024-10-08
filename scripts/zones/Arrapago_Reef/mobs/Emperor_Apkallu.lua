-----------------------------------
-- Area: Arrapago Reef
--  MOB: Emperor Apkallu
-----------------------------------
mixins = { require('scripts/mixins/families/apkallu') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
