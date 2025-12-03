-----------------------------------
-- ID: 4511
-- Item: Bowl of Ambrosia
-- Food Effect: 240Min, All Races
-----------------------------------
-- HP +7
-- MP +7
-- STR +7
-- DEX +7
-- VIT +7
-- AGI +7
-- INT +7
-- MND +7
-- CHR +7
-- Accuracy +7
-- Ranged Accuracy +7
-- Attack +7
-- Ranged Attack +7
-- Evasion +7
-- Defense +7
-- HP recovered while healing +7
-- MP recovered while healing +7
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
    effect:addMod(xi.mod.FOOD_HP, 7)
    effect:addMod(xi.mod.FOOD_MP, 7)
    effect:addMod(xi.mod.STR, 7)
    effect:addMod(xi.mod.DEX, 7)
    effect:addMod(xi.mod.VIT, 7)
    effect:addMod(xi.mod.AGI, 7)
    effect:addMod(xi.mod.INT, 7)
    effect:addMod(xi.mod.MND, 7)
    effect:addMod(xi.mod.CHR, 7)
    effect:addMod(xi.mod.ATT, 7)
    effect:addMod(xi.mod.RATT, 7)
    effect:addMod(xi.mod.ACC, 7)
    effect:addMod(xi.mod.RACC, 7)
    effect:addMod(xi.mod.HPHEAL, 7)
    effect:addMod(xi.mod.MPHEAL, 7)
    effect:addMod(xi.mod.DEF, 7)
    effect:addMod(xi.mod.EVA, 7)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
