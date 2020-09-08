-----------------------------------
--
-- tpz.effect.ASSASSINS_CHARGE
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.QUAD_ATTACK, effect:getPower())
    target:addMod(tpz.mod.TRIPLE_ATTACK, 100)
    if (effect:getSubType() > 0) then
        target:addMod(tpz.mod.CRITHITRATE, effect:getSubPower())
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.QUAD_ATTACK, effect:getPower())
    target:delMod(tpz.mod.TRIPLE_ATTACK, 100)
    if (effect:getSubPower() > 0) then -- tpz.mod.AUGMENTS_ASSASSINS_CHARGE
        target:delMod(tpz.mod.CRITHITRATE, effect:getSubPower())
    end
end
