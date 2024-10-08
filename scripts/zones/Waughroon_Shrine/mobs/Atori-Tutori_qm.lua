-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Atori-Tutori ???
-- BCNM: Beyond Infinity
-----------------------------------
mixins = { require('scripts/mixins/families/atori_tutori_qm') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
