-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Climbpix Highrise
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 97, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 98, 2, xi.regime.type.FIELDS)
end

return entity
