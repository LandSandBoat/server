-----------------------------------
-- xi.effect.SKILLCHAIN
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    -- Remove Sengikori "debuff" once the SC is gone
    target:setMod(xi.mod.SENGIKORI_SC_DMG_DEBUFF, 0)
    target:setMod(xi.mod.SENGIKORI_MB_DMG_DEBUFF, 0)
end

return effectObject
