-----------------------------------
-- Area: Dynamis - Tavnazia
--  Mob: Nightmare Leech
-----------------------------------
mixins = { require('scripts/mixins/dynamis_dreamland') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
    mob:setLocalVar('dynamis_currency', 1449)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
