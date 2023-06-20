-----------------------------------
-- ID: 5676
-- Item: serving_of_mushroom_sautee
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- MP 60
-- Mind 6
-- MP Recovered While Healing 6
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5676)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 60)
    target:addMod(xi.mod.MND, 6)
    target:addMod(xi.mod.MPHEAL, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 60)
    target:delMod(xi.mod.MND, 6)
    target:delMod(xi.mod.MPHEAL, 6)
end

return itemObject
