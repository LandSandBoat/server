-----------------------------------
-- Area: Ifrits Cauldron
--   NM: Tarasque
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 900)

    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)

    mob:addListener('MELEE_SWING_HIT', 'TARASQUE_BLAZE_SPIKES', function(mobArg, targetArg, attackArg)
        if not mobArg:hasStatusEffect(xi.effect.BLAZE_SPIKES) then
            mobArg:addStatusEffectEx(xi.effect.BLAZE_SPIKES, xi.effect.BLAZE_SPIKES, 50, 0, 3600, true)
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 403)
end

entity.onMobDespawn = function(mob)
    mob:removeListener('TARASQUE_BLAZE_SPIKES')
end

return entity
