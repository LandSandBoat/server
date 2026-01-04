-----------------------------------
-- Area: Ifrits Cauldron
--   NM: Tarasque
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 900)
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

return entity
