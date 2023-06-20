-----------------------------------
-- ID: 5216
-- Item: plate_of_tentacle_sushi_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- HP 20
-- Dexterity 3
-- Agility 3
-- Accuracy % 20 (cap 20)
-- Ranged Accuracy % 20 (cap 20)
-- Double Attack 1
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5216)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 20)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.AGI, 3)
    target:addMod(xi.mod.FOOD_ACCP, 20)
    target:addMod(xi.mod.FOOD_ACC_CAP, 20)
    target:addMod(xi.mod.FOOD_RACCP, 20)
    target:addMod(xi.mod.FOOD_RACC_CAP, 20)
    target:addMod(xi.mod.DOUBLE_ATTACK, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 20)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.AGI, 3)
    target:delMod(xi.mod.FOOD_ACCP, 20)
    target:delMod(xi.mod.FOOD_ACC_CAP, 20)
    target:delMod(xi.mod.FOOD_RACCP, 20)
    target:delMod(xi.mod.FOOD_RACC_CAP, 20)
    target:delMod(xi.mod.DOUBLE_ATTACK, 1)
end

return itemObject
