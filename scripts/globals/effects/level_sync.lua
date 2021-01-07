-----------------------------------
-- tpz.effect.LEVEL_SYNC
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:levelRestriction(effect:getPower())

    if target:getObjType() == tpz.objType.PC then
        target:clearTrusts()
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:levelRestriction(0)
    target:disableLevelSync()
end

return effect_object
