-----------------------------------
-- xi.effect.COSTUME
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:setCostume(effect:getPower())

    -- Special case for assault: "Breaking Morale"
    if effect:getPower() == 1602 then
        target:addMod(xi.mod.REGEN_DOWN, 33)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:setCostume(0)

    -- Special case for assault: "Breaking Morale"
    if effect:getPower() == 1602 then
        target:delMod(xi.mod.REGEN_DOWN, 33)
    end
end

return effectObject
