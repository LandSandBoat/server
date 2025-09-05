-----------------------------------
-- Area: Batallia Downs
--   NM: Eyegouger
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  177.300, y = -2.100, z = -54.540 }
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.BLIND)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 163)
end

return entity
