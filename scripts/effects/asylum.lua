-----------------------------------
-- xi.effect.ASYLUM
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SLEEP_MEVA, 98)
    target:addMod(xi.mod.POISON_MEVA, 98)
    target:addMod(xi.mod.PARALYZE_MEVA, 98)
    target:addMod(xi.mod.BLIND_MEVA, 98)
    target:addMod(xi.mod.SILENCE_MEVA, 98)
    target:addMod(xi.mod.VIRUS_MEVA, 98)
    target:addMod(xi.mod.PETRIFY_MEVA, 98)
    target:addMod(xi.mod.BIND_MEVA, 98)
    target:addMod(xi.mod.CURSE_MEVA, 98)
    target:addMod(xi.mod.GRAVITY_MEVA, 98)
    target:addMod(xi.mod.SLOW_MEVA, 98)
    target:addMod(xi.mod.STUN_MEVA, 98)
    target:addMod(xi.mod.CHARM_MEVA, 98)
    target:addMod(xi.mod.AMNESIA_MEVA, 98)
    target:addMod(xi.mod.LULLABY_MEVA, 98)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SLEEP_MEVA, 98)
    target:delMod(xi.mod.POISON_MEVA, 98)
    target:delMod(xi.mod.PARALYZE_MEVA, 98)
    target:delMod(xi.mod.BLIND_MEVA, 98)
    target:delMod(xi.mod.SILENCE_MEVA, 98)
    target:delMod(xi.mod.VIRUS_MEVA, 98)
    target:delMod(xi.mod.PETRIFY_MEVA, 98)
    target:delMod(xi.mod.BIND_MEVA, 98)
    target:delMod(xi.mod.CURSE_MEVA, 98)
    target:delMod(xi.mod.GRAVITY_MEVA, 98)
    target:delMod(xi.mod.SLOW_MEVA, 98)
    target:delMod(xi.mod.STUN_MEVA, 98)
    target:delMod(xi.mod.CHARM_MEVA, 98)
    target:delMod(xi.mod.AMNESIA_MEVA, 98)
    target:delMod(xi.mod.LULLABY_MEVA, 98)
end

return effectObject
