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
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 45)
    effect:addMod(xi.mod.STR, 6)
    effect:addMod(xi.mod.FOOD_ATTP, 19)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 95)
    effect:addMod(xi.mod.UNDEAD_KILLER, 6)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
