-----------------------------------------
-- ID: 15446
-- Item: Goldsmith's Belt
-- Enchantment: Synthesis image support
-- 2Min, All Races
-----------------------------------------
-- Enchantment: Synthesis image support
-- Duration: 2Min
-- Goldsmithing Skill +3
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.GOLDSMITHING_IMAGERY) == true) then
        result = 238
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.GOLDSMITHING_IMAGERY, 3, 0, 120)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.GOLDSMITH, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.GOLDSMITH, 1)
end
