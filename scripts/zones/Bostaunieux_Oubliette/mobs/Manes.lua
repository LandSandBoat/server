-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--   NM: Manes
-----------------------------------
local ID = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -60.400, y =  17.000, z = -138.000 }
}

entity.phList =
{
    [ID.mob.MANES - 2] = ID.mob.MANES,
    [ID.mob.MANES - 1] = ID.mob.MANES,
    [ID.mob.MANES + 5] = ID.mob.MANES,
    [ID.mob.MANES + 6] = ID.mob.MANES,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TERROR)
end

entity.onMobRoam = function(mob)
    if VanadielHour() >= 6 and VanadielHour() < 18 then -- Despawn if its day
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 180)
end

return entity
