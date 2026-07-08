-----------------------------------
-- xi.effect.CHARM
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if effect:getSubPower() > 0 then -- Chariots have a DOT on charm from Brainjack skill.
        effect:addMod(xi.mod.REGEN_DOWN, effect:getSubPower())
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:setTP(0)
    target:uncharm()
end

return effectObject
