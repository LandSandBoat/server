-----------------------------------
-- xi.effect.PERFECT_DEFENSE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.UDMGPHYS, -effect:getPower())
    target:addMod(xi.mod.UDMGBREATH, -effect:getPower())
    target:addMod(xi.mod.UDMGMAGIC, -effect:getPower())
    target:addMod(xi.mod.UDMGRANGE, -effect:getPower())
    target:addMod(xi.mod.SLEEP_MEVA, effect:getPower())
    target:addMod(xi.mod.POISON_MEVA, effect:getPower())
    target:addMod(xi.mod.PARALYZE_MEVA, effect:getPower())
    target:addMod(xi.mod.BLIND_MEVA, effect:getPower())
    target:addMod(xi.mod.SILENCE_MEVA, effect:getPower())
    target:addMod(xi.mod.BIND_MEVA, effect:getPower())
    target:addMod(xi.mod.CURSE_MEVA, effect:getPower())
    target:addMod(xi.mod.SLOW_MEVA, effect:getPower())
    target:addMod(xi.mod.STUN_MEVA, effect:getPower())
    target:addMod(xi.mod.CHARM_MEVA, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    if effect:getTickCount() > ((effect:getDuration() / effect:getTick()) / 2) then
        if effect:getPower() > 2 then
            effect:setPower(effect:getPower() - 200)
            target:delMod(xi.mod.UDMGPHYS, -200)
            target:delMod(xi.mod.UDMGBREATH, -200)
            target:delMod(xi.mod.UDMGMAGIC, -300)
            target:delMod(xi.mod.UDMGRANGE, -200)
            target:delMod(xi.mod.SLEEP_MEVA, 2)
            target:delMod(xi.mod.POISON_MEVA, 2)
            target:delMod(xi.mod.PARALYZE_MEVA, 2)
            target:delMod(xi.mod.BLIND_MEVA, 2)
            target:delMod(xi.mod.SILENCE_MEVA, 2)
            target:delMod(xi.mod.BIND_MEVA, 2)
            target:delMod(xi.mod.CURSE_MEVA, 2)
            target:delMod(xi.mod.SLOW_MEVA, 2)
            target:delMod(xi.mod.STUN_MEVA, 2)
            target:delMod(xi.mod.CHARM_MEVA, 2)
        end
    end
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.UDMGPHYS, -effect:getPower())
    target:delMod(xi.mod.UDMGBREATH, -effect:getPower())
    target:delMod(xi.mod.UDMGMAGIC, -effect:getSubPower())
    target:delMod(xi.mod.UDMGRANGE, -effect:getPower())
    target:delMod(xi.mod.SLEEP_MEVA, effect:getPower())
    target:delMod(xi.mod.POISON_MEVA, effect:getPower())
    target:delMod(xi.mod.PARALYZE_MEVA, effect:getPower())
    target:delMod(xi.mod.BLIND_MEVA, effect:getPower())
    target:delMod(xi.mod.SILENCE_MEVA, effect:getPower())
    target:delMod(xi.mod.BIND_MEVA, effect:getPower())
    target:delMod(xi.mod.CURSE_MEVA, effect:getPower())
    target:delMod(xi.mod.SLOW_MEVA, effect:getPower())
    target:delMod(xi.mod.STUN_MEVA, effect:getPower())
    target:delMod(xi.mod.CHARM_MEVA, effect:getPower())
end

return effectObject
