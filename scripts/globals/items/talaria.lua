-----------------------------------------
-- ID: 11403
-- Item: Talaria
-- Enchantment: Increases movement speed.
-- Durration: 60 Mins
-----------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    if (target:hasStatusEffect(tpz.effect.ENCHANTMENT) == false) then
        target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 3600, 11403)
    end
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MOVE, 15)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MOVE, 15)
end
