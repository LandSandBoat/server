-----------------------------------
-- ID: 5559
-- Item: Serving of Mille Feuille
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +8
-- MP +15
-- Intelligence +1
-- HP Recoverd while healing 1
-- MP Recovered while healing 1
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5559)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 8)
    target:addMod(xi.mod.MP, 15)
    target:addMod(xi.mod.INT, 1)
    target:addMod(xi.mod.HPHEAL, 1)
    target:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 8)
    target:delMod(xi.mod.MP, 15)
    target:delMod(xi.mod.INT, 1)
    target:delMod(xi.mod.HPHEAL, 1)
    target:delMod(xi.mod.MPHEAL, 1)
end

return itemObject
