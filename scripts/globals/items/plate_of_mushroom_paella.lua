-----------------------------------
-- ID: 5970
-- Item: Plate of Mushroom Paella
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- HP 40
-- Strength -1
-- Mind 5
-- Magic Accuracy 5
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5970)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 40)
    target:addMod(xi.mod.STR, -1)
    target:addMod(xi.mod.MND, 5)
    target:addMod(xi.mod.MACC, 5)
    target:addMod(xi.mod.UNDEAD_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 40)
    target:delMod(xi.mod.STR, -1)
    target:delMod(xi.mod.MND, 5)
    target:delMod(xi.mod.MACC, 5)
    target:delMod(xi.mod.UNDEAD_KILLER, 5)
end

return itemObject
