-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Masan
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  1.178, y =  10.799, z =  178.807 }
}

entity.phList =
{
    [ID.mob.MASAN - 4] = ID.mob.MASAN, -- 17.001 9.340 186.571
    [ID.mob.MASAN - 3] = ID.mob.MASAN, -- 18.702 9.512 183.594
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)

    mob:addImmunity(xi.immunity.TERROR)

    mob:setMobMod(xi.mobMod.GIL_MIN, 1200)
    mob:setMobMod(xi.mobMod.GIL_MAX, 1200)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TP_DRAIN, { power = (math.random(250, 500)) })  -- Wiki reports of HP drain add effect seem to be made up, only TP drain found in extensive testing
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 371)
end

return entity
