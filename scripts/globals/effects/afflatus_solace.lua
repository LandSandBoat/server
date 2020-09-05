-----------------------------------
--
-- tpz.effect.AFFLATUS_SOLACE
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.AFFLATUS_SOLACE, 0)
    target:addMod(tpz.mod.BARSPELL_MDEF_BONUS, 5)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.AFFLATUS_SOLACE, 0)
    target:delMod(tpz.mod.BARSPELL_MDEF_BONUS, 5)
end
