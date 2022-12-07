-----------------------------------
-- xi.effect.SUPER_BUFF
-- This is only used for Nidhogg
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.UDMGMAGIC, -500)
    target:addMod(xi.mod.UDMGPHYS, -5000)
    target:addMod(xi.mod.UDMGRANGE, -5000)
    target:addMod(xi.mod.EVA, 378)
    -- The following only applies to Nidhogg.  If this buff is to be used anywhere else, a check on mob name (NOT ID) would be a good choice
    target:setAnimationSub(2)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DMGMAGIC, -500)
    target:delMod(xi.mod.DMGPHYS, -5000)
    target:delMod(xi.mod.DMGRANGE, -5000)
    target:delMod(xi.mod.EVA, 378)
    target:setAnimationSub(0)
end

return effectObject
