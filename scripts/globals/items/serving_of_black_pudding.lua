-----------------------------------
-- ID: 5552
-- Item: Serving of Black Pudding
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +8
-- MP +5% Cap 25
-- Intelligence +4
-- HP Recovered while healing +1
-- MP Recovered while healing +1
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5552)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 5)
    target:addMod(xi.mod.FOOD_MP_CAP, 25)
    target:addMod(xi.mod.HP, 8)
    target:addMod(xi.mod.INT, 4)
    target:addMod(xi.mod.HPHEAL, 1)
    target:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 5)
    target:delMod(xi.mod.FOOD_MP_CAP, 25)
    target:delMod(xi.mod.HP, 8)
    target:delMod(xi.mod.INT, 4)
    target:delMod(xi.mod.HPHEAL, 1)
    target:delMod(xi.mod.MPHEAL, 1)
end

return itemObject
