-----------------------------------
-- xi.effect.WEIGHT
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local moveMod = effect:getPower() * (-1 * (50 + xi.settings.map.SPEED_MOD) / 50)
    target:addMod(xi.mod.MOVE, moveMod)
    target:addMod(xi.mod.EVA, -10)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local moveMod = effect:getPower() * (-1 * (50 + xi.settings.map.SPEED_MOD) / 50)
    target:delMod(xi.mod.MOVE, moveMod)
    target:delMod(xi.mod.EVA, -10)
end

return effectObject
