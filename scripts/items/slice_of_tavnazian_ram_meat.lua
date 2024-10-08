-----------------------------------
-- ID: 5208
-- Item: slice_of_tavnazian_ram_meat
-- Food Effect: 5Min, Galka only
-----------------------------------
-- Strength 2
-- Mind -4
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.RAW_MEAT)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5208)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 2)
    target:addMod(xi.mod.MND, -4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 2)
    target:delMod(xi.mod.MND, -4)
end

return itemObject
