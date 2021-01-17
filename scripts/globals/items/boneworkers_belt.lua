-----------------------------------------
-- ID: 15449
-- Item: Boneworker's belt
-- Enchantment: Synthesis image support
-- 2Min, All Races
-----------------------------------------
-- Enchantment: Synthesis image support
-- Duration: 2Min
-- Bonecraft Skill +3
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.BONECRAFT_IMAGERY) == true) then
        result = 241
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.BONECRAFT_IMAGERY, 3, 0, 120)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.BONE, 1)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.BONE, 1)
end

return item_object
