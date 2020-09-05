-----------------------------------------
-- ID: 17826
-- Item: Messhikimaru
-- Enchantment: Arcana Killer
-- Durration: 10 Mins
-----------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    result = 0
end

function onItemUse(target)
    if (target:hasStatusEffect(tpz.effect.ENCHANTMENT) == false) then
        target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 600, 17826)
    end
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ARCANA_KILLER, 20)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ARCANA_KILLER, 20)
end

