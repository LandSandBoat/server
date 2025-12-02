-----------------------------------
-- Area: Fei'Yin
--  NM: Mind Hoarder
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  40.000, y = -15.500, z = -38.000 }
}

entity.phList =
{
    [ID.mob.MIND_HOARDER - 3] = ID.mob.MIND_HOARDER,
    [ID.mob.MIND_HOARDER - 2] = ID.mob.MIND_HOARDER,
    [ID.mob.MIND_HOARDER - 1] = ID.mob.MIND_HOARDER,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, { power = 70 })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 347)
end

return entity
