-----------------------------------------
-- ID: 15445
-- Item: Blacksmith's Belt
-- Enchantment: Synthesis image support
-- 2Min, All Races
-----------------------------------------
-- Enchantment: Synthesis image support
-- Duration: 2Min
-- Smithing Skill +3
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.SMITHING_IMAGERY) == true) then
        result = 237
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.SMITHING_IMAGERY, 3, 0, 120)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.SMITH, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.SMITH, 1)
end
