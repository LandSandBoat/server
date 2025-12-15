-----------------------------------
-- ID: 5595
-- Item: Bowl of Nashmau Stew
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- MP -100
-- Vitality -10
-- Agility -10
-- Intelligence -10
-- Mind -10
-- Charisma -10
-- Accuracy +15% Cap 25
-- Attack +18% Cap 60
-- Defense -100
-- Evasion -100
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
    effect:addMod(xi.mod.FOOD_MP, -100)
    effect:addMod(xi.mod.VIT, -10)
    effect:addMod(xi.mod.AGI, -10)
    effect:addMod(xi.mod.INT, -10)
    effect:addMod(xi.mod.MND, -10)
    effect:addMod(xi.mod.CHR, -10)
    effect:addMod(xi.mod.FOOD_ACCP, 15)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 25)
    effect:addMod(xi.mod.FOOD_ATTP, 18)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 60)
    effect:addMod(xi.mod.DEF, -100)
    effect:addMod(xi.mod.EVA, -100)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
