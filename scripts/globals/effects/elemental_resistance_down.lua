
-----------------------------------
--
--     tpz.effect.ELEMENTALRES_DOWN
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target,effect)
    target:addMod(tpz.mod.FIRERES, -effect:getPower())
    target:addMod(tpz.mod.ICERES, -effect:getPower())
    target:addMod(tpz.mod.WINDRES, -effect:getPower())
    target:addMod(tpz.mod.EARTHRES, -effect:getPower())
    target:addMod(tpz.mod.THUNDERRES, -effect:getPower())
    target:addMod(tpz.mod.WATERRES, -effect:getPower())
    target:addMod(tpz.mod.LIGHTRES, -effect:getPower())
    target:addMod(tpz.mod.DARKRES, -effect:getPower())
end

function onEffectTick(target,effect)
end


function onEffectLose(target,effect)
    target:delMod(tpz.mod.FIRERES, -effect:getPower())
    target:delMod(tpz.mod.ICERES, -effect:getPower())
    target:delMod(tpz.mod.WINDRES, -effect:getPower())
    target:delMod(tpz.mod.EARTHRES, -effect:getPower())
    target:delMod(tpz.mod.THUNDERRES, -effect:getPower())
    target:delMod(tpz.mod.WATERRES, -effect:getPower())
    target:delMod(tpz.mod.LIGHTRES, -effect:getPower())
    target:delMod(tpz.mod.DARKRES, -effect:getPower())
end