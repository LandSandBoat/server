-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Apocalyptic Beast
-- Note: Mega Boss
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.megaBossOnDeath(mob, player, optParams)
end

return entity
