-----------------------------------------
-- ID: 17592
-- Item: Kinkobo
-- Enchantment: Subtle Blow
-- Duration: 60 Mins
-----------------------------------------

require("scripts/globals/status")
require("scripts/globals/settings")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    if (target:addStatusEffect(tpz.effect.ENCHANTMENT) == false) then
        target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 3600, 17592)
    end
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.SUBTLE_BLOW, 20)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.SUBTLE_BLOW, 20)
end
