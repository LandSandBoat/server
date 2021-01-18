-----------------------------------
-- ID: 15450
-- Item: Alchemist's belt
-- Enchantment: Synthesis image support
-- 2Min, All Races
-----------------------------------
-- Enchantment: Synthesis image support
-- Duration: 2Min
-- Alchemy Skill +3
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.ALCHEMY_IMAGERY) == true) then
        result = 242
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.ALCHEMY_IMAGERY, 3, 0, 120)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.ALCHEMY, 1)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.ALCHEMY, 1)
end

return item_object
