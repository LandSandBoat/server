-----------------------------------
-- Area: FeiYin
--   NM: Sluagh
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  -43.447, y =   0.575, z = 167.079 },
    { x = -131.235, y =   0.045, z =   6.837 },
    { x = -112.805, y = -15.474, z = -54.460 },
    { x =  -27.537, y = -16.015, z =  43.224 },
    { x = -162.339, y = -15.523, z = -84.963 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.PLAGUE)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
    mob:setMod(xi.mod.STORETP, 125) -- 6 hits to 1k tp
end

entity.onMobMobskillChoose = function(mob, target)
    return xi.mobSkill.GRAVE_REEL
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 349)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
