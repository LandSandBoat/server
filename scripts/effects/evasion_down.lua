-----------------------------------
-- xi.effect.EVASION_DOWN
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if effect:getSubType() == 1 then
        target:delMod(xi.mod.EVA_PERCENT, effect:getPower())
        return
    end

    local power = math.min(effect:getPower(), target:getStat(xi.mod.EVA))
    effect:setPower(power)
    target:delMod(xi.mod.EVA, power)
end

-- only Feint uses tick, which restores 10 evasion per tick
effectObject.onEffectTick = function(target, effect)
    local power = effect:getPower()
    local adj = math.min(power, 10)
    effect:setPower(power - adj)

    if effect:getSubType() == 1 then
        target:addMod(xi.mod.EVA_PERCENT, adj)
    else
        target:addMod(xi.mod.EVA, adj)
    end
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower()
    if effect:getSubType() == 1 then
        target:addMod(xi.mod.EVA_PERCENT, power)
    else
        target:addMod(xi.mod.EVA, power)
    end
end

return effectObject
