-----------------------------------
-- Area: FeiYin
--  Mob: Miser Murphy
--  Quest: Peace for the Spirit
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 10)
    mob:setMod(xi.mod.BIND_RES_RANK, 10)
    mob:setMod(xi.mod.BLIND_RES_RANK, 10)
    mob:setMod(xi.mod.STUN_MEVA, 10000)
    mob:setMod(xi.mod.DARK_RES_RANK, 10)
    mob:setMod(xi.mod.ICE_RES_RANK, 10)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, { chance = 15, power = math.random(450, 550) }) -- This drain needs to be changed to physical damage
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
