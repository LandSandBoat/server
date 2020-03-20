-----------------------------------
--
-- tpz.effect.CHOKE
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onEffectGain(target,effect)
    target:addMod(tpz.mod.VIT, -getElementalDebuffStatDownFromDOT(effect:getPower()) - effect:getSubPower())
    target:addMod(tpz.mod.REGEN_DOWN, effect:getPower())
end

function onEffectTick(target,effect)
end

function onEffectLose(target,effect)
    target:delMod(tpz.mod.VIT, -getElementalDebuffStatDownFromDOT(effect:getPower()) - effect:getSubPower())
    target:delMod(tpz.mod.REGEN_DOWN, effect:getPower())
end
