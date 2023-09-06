-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Nightmare Uragnite
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_dreamland'),
    require('scripts/mixins/families/uragnite'),
}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('dynamis_currency', 1455)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
