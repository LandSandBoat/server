-----------------------------------
-- xi.effect.SUPER_BUFF
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.ATTP, 25)
    effect:addMod(xi.mod.DMGMAGIC, -500)
    effect:addMod(xi.mod.DMGPHYS, -5000)
    effect:addMod(xi.mod.EVA, 378)
    -- The following only applies to Nidhogg.  If this buff is to be used anywhere else, a check on mob name (NOT ID) would be a good choice
    target:setAnimationSub(2)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:setAnimationSub(0)
end

return effectObject
