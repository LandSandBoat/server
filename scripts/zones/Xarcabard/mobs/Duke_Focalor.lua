-----------------------------------
-- Area: Xarcabard
--   NM: Duke Focalor
--  WOTG Nov 2009 NM: Immune to Bind, Sleep, Gravity. Uses only 1 TP move.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = 36.000, y = -36.000, z = 160.000 },
    { x = 42.000, y = -35.998, z = 154.000 },
    { x = 38.000, y = -35.998, z = 153.000 },
    { x = 16.000, y = -35.459, z = 158.000 },
    { x =  2.000, y = -35.423, z = 148.000 },
    { x = 39.000, y = -35.999, z = 126.000 },
    { x = 44.000, y = -36.000, z = 119.000 },
    { x = 47.000, y = -36.000, z = 126.000 },
    { x = 46.000, y = -35.690, z = 137.000 },
    { x = 37.000, y = -35.998, z = 153.000 },
    { x = 36.000, y = -36.000, z = 160.000 },
    { x = 42.000, y = -35.998, z = 154.000 },
    { x = 38.000, y = -35.998, z = 153.000 },
    { x = 16.000, y = -35.459, z = 158.000 },
    { x =  2.000, y = -35.423, z = 148.000 },
    { x = 39.000, y = -35.999, z = 126.000 },
    { x = 44.000, y = -36.000, z = 119.000 },
    { x = 47.000, y = -36.000, z = 126.000 },
    { x = 46.000, y = -35.690, z = 137.000 },
    { x = 37.000, y = -35.998, z = 153.000 },
    { x = 36.000, y = -36.000, z = 160.000 },
    { x = 42.000, y = -35.998, z = 154.000 },
    { x = 38.000, y = -35.998, z = 153.000 },
    { x = 16.000, y = -35.459, z = 158.000 },
    { x =  2.000, y = -35.423, z = 148.000 },
    { x = 39.000, y = -35.999, z = 126.000 },
    { x = 44.000, y = -36.000, z = 119.000 },
    { x = 47.000, y = -36.000, z = 126.000 },
    { x = 46.000, y = -35.690, z = 137.000 },
    { x = 37.000, y = -35.998, z = 153.000 },
    { x = 36.000, y = -36.000, z = 160.000 },
    { x = 42.000, y = -35.998, z = 154.000 },
    { x = 38.000, y = -35.998, z = 153.000 },
    { x = 16.000, y = -35.459, z = 158.000 },
    { x =  2.000, y = -35.423, z = 148.000 },
    { x = 39.000, y = -35.999, z = 126.000 },
    { x = 44.000, y = -36.000, z = 119.000 },
    { x = 47.000, y = -36.000, z = 126.000 },
    { x = 46.000, y = -35.690, z = 137.000 },
    { x = 37.000, y = -35.998, z = 153.000 },
    { x = 36.000, y = -36.000, z = 160.000 },
    { x = 42.000, y = -35.998, z = 154.000 },
    { x = 38.000, y = -35.998, z = 153.000 },
    { x = 16.000, y = -35.459, z = 158.000 },
    { x =  2.000, y = -35.423, z = 148.000 },
    { x = 39.000, y = -35.999, z = 126.000 },
    { x = 44.000, y = -36.000, z = 119.000 },
    { x = 47.000, y = -36.000, z = 126.000 },
    { x = 46.000, y = -35.690, z = 137.000 },
    { x = 37.000, y = -35.998, z = 153.000 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(5400, 7200)) -- When server restarts, reset timer

    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:setMod(xi.mod.STORETP, 80)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 316)
    xi.regime.checkRegime(player, mob, 55, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(5400, 7200)) -- 1.5 to 2 hours
end

return entity
