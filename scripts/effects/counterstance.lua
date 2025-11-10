-----------------------------------
-- xi.effect..COUNTERSTANCE
-- DEF is removed in core as equip swaps can mess this up otherwise!
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if target:isMob() and target:getFamily() == 59 then -- Bugbear Family
        effect:addMod(xi.mod.ATTP, 15)
    end

    target:addMod(xi.mod.COUNTER, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.COUNTER, effect:getPower())
end

return effectObject
