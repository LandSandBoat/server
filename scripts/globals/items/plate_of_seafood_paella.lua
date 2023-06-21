-----------------------------------
-- ID: 5968
-- Item: Plate of Seafood Paella
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- HP 40
-- Dexterity 5
-- Mind -1
-- Accuracy % 15 (cap 80)
-- Undead Killer 5
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5968)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 40)
    target:addMod(xi.mod.DEX, 5)
    target:addMod(xi.mod.MND, -1)
    target:addMod(xi.mod.FOOD_ACCP, 15)
    target:addMod(xi.mod.FOOD_ACC_CAP, 80)
    target:addMod(xi.mod.UNDEAD_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 40)
    target:delMod(xi.mod.DEX, 5)
    target:delMod(xi.mod.MND, -1)
    target:delMod(xi.mod.FOOD_ACCP, 15)
    target:delMod(xi.mod.FOOD_ACC_CAP, 80)
    target:delMod(xi.mod.UNDEAD_KILLER, 5)
end

return itemObject
