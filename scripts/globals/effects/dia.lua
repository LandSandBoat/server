-----------------------------------
-- xi.effect.DIA
-----------------------------------
-- Quick Explanation of Algorithm:
-- Dia 1: Power of 1. Results in reduced defense of ~5.27%  (27/512) and 1 hp/tick damage.
-- Dia 2: Power of 2. Results in reduced defense of ~10.35% (53/512) and 2 hp/tick damage.
-- Dia 3: Power of 3. Results in reduced defense of ~15.4%  (79/512) and 3 hp/tick damage.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()
    local subpower = effect:getSubPower()
    target:addMod(xi.mod.REGEN_DOWN, power)
    target:addMod(xi.mod.DEFP, -subpower)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower()
    local subpower = effect:getSubPower()
    target:delMod(xi.mod.REGEN_DOWN, power)
    target:delMod(xi.mod.DEFP, -subpower)
end

return effectObject
