-----------------------------------
-- ID: 5746
-- Item: serving_of_cherry_bavarois_+1
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- HP 30
-- Intelligence 4
-- MP 15
-- HP Recovered While Healing 4
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5746)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 30)
    target:addMod(xi.mod.INT, 4)
    target:addMod(xi.mod.MP, 15)
    target:addMod(xi.mod.HPHEAL, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 30)
    target:delMod(xi.mod.INT, 4)
    target:delMod(xi.mod.MP, 15)
    target:delMod(xi.mod.HPHEAL, 4)
end

return itemObject
