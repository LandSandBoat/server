-----------------------------------
-- ID: 5973
-- Item: Plate of Beef Paella +1
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- HP 45
-- Strength 6
-- Attack % 19 Cap 95
-- Undead Killer 6
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5973)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 45)
    target:addMod(xi.mod.STR, 6)
    target:addMod(xi.mod.FOOD_ATTP, 19)
    target:addMod(xi.mod.FOOD_ATT_CAP, 95)
    target:addMod(xi.mod.UNDEAD_KILLER, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 45)
    target:delMod(xi.mod.STR, 6)
    target:delMod(xi.mod.FOOD_ATTP, 19)
    target:delMod(xi.mod.FOOD_ATT_CAP, 95)
    target:delMod(xi.mod.UNDEAD_KILLER, 6)
end

return itemObject
