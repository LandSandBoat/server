-----------------------------------
-- xi.effect.PERFECT_DEFENSE
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.UDMGPHYS, -effect:getPower())
    target:addMod(xi.mod.UDMGBREATH, -effect:getPower())
    target:addMod(xi.mod.UDMGMAGIC, -effect:getPower())
    target:addMod(xi.mod.UDMGRANGE, -effect:getPower())
    target:addMod(xi.mod.SLEEP_MEVA, effect:getSubPower())
    target:addMod(xi.mod.POISON_MEVA, effect:getSubPower())
    target:addMod(xi.mod.PARALYZE_MEVA, effect:getSubPower())
    target:addMod(xi.mod.BLIND_MEVA, effect:getSubPower())
    target:addMod(xi.mod.SILENCE_MEVA, effect:getSubPower())
    target:addMod(xi.mod.BIND_MEVA, effect:getSubPower())
    target:addMod(xi.mod.CURSE_MEVA, effect:getSubPower())
    target:addMod(xi.mod.SLOW_MEVA, effect:getSubPower())
    target:addMod(xi.mod.STUN_MEVA, effect:getSubPower())
    target:addMod(xi.mod.CHARM_MEVA, effect:getSubPower())
    target:addMod(xi.mod.PETRIFY_MEVA, effect:getSubPower())
    target:addMod(xi.mod.AMNESIA_MEVA, effect:getSubPower())
    target:addMod(xi.mod.GRAVITY_MEVA, effect:getSubPower())
    target:addMod(xi.mod.VIRUS_MEVA, effect:getSubPower())
end

effectObject.onEffectTick = function(target, effect)
    if effect:getTickCount() >= math.floor(effect:getDuration() / (2 * effect:getTick())) then
        if effect:getPower() > 600 then
            effect:setPower(effect:getPower() - 600)
            effect:setSubPower(effect:getSubPower() - 6)
            target:delMod(xi.mod.UDMGPHYS, -600)
            target:delMod(xi.mod.UDMGBREATH, -600)
            target:delMod(xi.mod.UDMGMAGIC, -600)
            target:delMod(xi.mod.UDMGRANGE, -600)
            target:delMod(xi.mod.SLEEP_MEVA, 6)
            target:delMod(xi.mod.POISON_MEVA, 6)
            target:delMod(xi.mod.PARALYZE_MEVA, 6)
            target:delMod(xi.mod.BLIND_MEVA, 6)
            target:delMod(xi.mod.SILENCE_MEVA, 6)
            target:delMod(xi.mod.BIND_MEVA, 6)
            target:delMod(xi.mod.CURSE_MEVA, 6)
            target:delMod(xi.mod.SLOW_MEVA, 6)
            target:delMod(xi.mod.STUN_MEVA, 6)
            target:delMod(xi.mod.CHARM_MEVA, 6)
            target:delMod(xi.mod.PETRIFY_MEVA, 6)
            target:delMod(xi.mod.AMNESIA_MEVA, 6)
            target:delMod(xi.mod.GRAVITY_MEVA, 6)
            target:delMod(xi.mod.VIRUS_MEVA, 6)
        end
    end
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.UDMGPHYS, -effect:getPower())
    target:delMod(xi.mod.UDMGBREATH, -effect:getPower())
    target:delMod(xi.mod.UDMGMAGIC, -effect:getPower())
    target:delMod(xi.mod.UDMGRANGE, -effect:getPower())
    target:delMod(xi.mod.SLEEP_MEVA, effect:getSubPower())
    target:delMod(xi.mod.POISON_MEVA, effect:getSubPower())
    target:delMod(xi.mod.PARALYZE_MEVA, effect:getSubPower())
    target:delMod(xi.mod.BLIND_MEVA, effect:getSubPower())
    target:delMod(xi.mod.SILENCE_MEVA, effect:getSubPower())
    target:delMod(xi.mod.BIND_MEVA, effect:getSubPower())
    target:delMod(xi.mod.CURSE_MEVA, effect:getSubPower())
    target:delMod(xi.mod.SLOW_MEVA, effect:getSubPower())
    target:delMod(xi.mod.STUN_MEVA, effect:getSubPower())
    target:delMod(xi.mod.CHARM_MEVA, effect:getSubPower())
    target:delMod(xi.mod.PETRIFY_MEVA, effect:getSubPower())
    target:delMod(xi.mod.AMNESIA_MEVA, effect:getSubPower())
    target:delMod(xi.mod.GRAVITY_MEVA, effect:getSubPower())
    target:delMod(xi.mod.VIRUS_MEVA, effect:getSubPower())
end

return effectObject
