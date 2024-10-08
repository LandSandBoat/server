-----------------------------------
-- ID: 15444
-- Item: Carpenter's belt
-- Enchantment: Synthesis image support
-- 8Min, All Races
-----------------------------------
-- Enchantment: Synthesis image support
-- Duration: 8Min
-- Woodworking Skill +3
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result = 0
    if target:hasStatusEffect(xi.effect.WOODWORKING_IMAGERY) then
        result = 236
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.WOODWORKING_IMAGERY, 3, 0, 480)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.WOOD, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.WOOD, 1)
end

return itemObject
