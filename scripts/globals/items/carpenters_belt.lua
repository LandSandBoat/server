-----------------------------------------
-- ID: 15444
-- Item: Carpenter's belt
-- Enchantment: Synthesis image support
-- 2Min, All Races
-----------------------------------------
-- Enchantment: Synthesis image support
-- Duration: 2Min
-- Woodworking Skill +3
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.WOODWORKING_IMAGERY) == true) then
        result = 236
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.WOODWORKING_IMAGERY, 3, 0, 120)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.WOOD, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.WOOD, 1)
end
