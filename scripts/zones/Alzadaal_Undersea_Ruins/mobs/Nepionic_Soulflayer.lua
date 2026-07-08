-----------------------------------
-- Area: Alzadaal Undersea Ruins (72)
--  Mob: Nepionic Soulflayer
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}
--TODO: Immortal Shield - Magic Shield (Only prevents direct damage from spells)
--TODO: Immortal Mind - Magic Atk Boost

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)

    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.STUN)

    mob:setMobMod(xi.mobMod.MAGIC_COOL, 35)
    mob:setMod(xi.mod.FASTCAST, 50)
    mob:setMod(xi.mod.REGAIN, 50)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
    mob:setMod(xi.mod.DARK_RES_RANK, 10)
    mob:setMod(xi.mod.WATER_RES_RANK, 10)
    mob:setMod(xi.mod.POISON_RES_RANK, 10)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.ATT, 330)
end

return entity
