-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ENSPELL, tpz.magic.element.WATER + 8) -- Tier IIs have higher "enspell IDs"
    target:addMod(tpz.mod.ENSPELL_DMG, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:setMod(tpz.mod.ENSPELL_DMG, 0)
    target:setMod(tpz.mod.ENSPELL, 0)
end
