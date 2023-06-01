-----------------------------------
-- ID: 5550
-- Item: Roll of Buche Au Chocolat
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +8
-- MP +3% Cap 13
-- Intelligence +2
-- HP Recovered while healing +1
-- MP Recovered while healing +4
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5550)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 3)
    target:addMod(xi.mod.FOOD_MP_CAP, 13)
    target:addMod(xi.mod.HP, 8)
    target:addMod(xi.mod.INT, 2)
    target:addMod(xi.mod.HPHEAL, 1)
    target:addMod(xi.mod.MPHEAL, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 3)
    target:delMod(xi.mod.FOOD_MP_CAP, 13)
    target:delMod(xi.mod.HP, 8)
    target:delMod(xi.mod.INT, 2)
    target:delMod(xi.mod.HPHEAL, 1)
    target:delMod(xi.mod.MPHEAL, 4)
end

return itemObject
