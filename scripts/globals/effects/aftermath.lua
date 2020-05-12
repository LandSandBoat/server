-----------------------------------
--
-- tpz.effect.AFTERMATH
--
-----------------------------------
require("scripts/globals/aftermath")
-----------------------------------

function onEffectGain(target, effect)
    tpz.aftermath.onEffectGain(target, effect)
end

function onEffectLose(target, effect)
    tpz.aftermath.onEffectLose(target, effect)
end
