-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect) --power=30 initially, subpower=20 for enmity
    target:addMod(tpz.mod.ACC, -effect:getPower())
    target:addMod(tpz.mod.NINJA_TOOL, effect:getPower())
    target:addMod(tpz.mod.ENMITY, effect:getSubPower())

    local yoninMerits = target:getMerit(tpz.merit.YONIN_EFFECT)
    if yoninMerits ~= 0 then
        target:addMod(tpz.mod.HP, yoninMerits)
    end
end

function onEffectTick(target, effect)
    --tick down the effect and reduce the overall power
    effect:setPower(effect:getPower()-1)
    target:delMod(tpz.mod.ACC, -1)
    target:delMod(tpz.mod.NINJA_TOOL, 1)
    if (effect:getPower() % 2 == 0) then -- enmity+ decays from 20 to 10, so half as often as the rest.
        effect:setSubPower(effect:getSubPower()-1)
        target:delMod(tpz.mod.ENMITY, 1)
    end
end

function onEffectLose(target, effect)
    --remove the remaining power
    target:delMod(tpz.mod.ACC, -effect:getPower())
    target:delMod(tpz.mod.NINJA_TOOL, effect:getPower())
    target:delMod(tpz.mod.ENMITY, effect:getSubPower())

    local yoninMerits = target:getMerit(tpz.merit.YONIN_EFFECT)
    if yoninMerits ~= 0 then
        target:delMod(tpz.mod.HP, yoninMerits)
    end
end
