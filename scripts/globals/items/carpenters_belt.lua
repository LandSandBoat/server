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
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.WOODWORKING_IMAGERY) == true) then
        result = 236
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.WOODWORKING_IMAGERY, 3, 0, 120)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.WOOD, 1)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.WOOD, 1)
end

return item_object
