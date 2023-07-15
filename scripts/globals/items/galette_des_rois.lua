-----------------------------------
-- ID: 5875
-- Item: Galette Des Rois
-- Food Effect: 180 Min, All Races
-----------------------------------
-- HP +8
-- MP +3% (cap13)
-- Intelligence +2
-- Random Jewel
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5875)
    local rand = math.random(784, 815)
    target:addItem(rand) -- Random Jewel
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 8)
    target:addMod(xi.mod.FOOD_MPP, 3)
    target:addMod(xi.mod.FOOD_MP_CAP, 13)
    target:addMod(xi.mod.INT, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 8)
    target:delMod(xi.mod.FOOD_MPP, 3)
    target:delMod(xi.mod.FOOD_MP_CAP, 13)
    target:delMod(xi.mod.INT, 2)
end

return itemObject
