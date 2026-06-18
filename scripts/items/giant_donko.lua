-----------------------------------
-- ID: 4306
-- Item: Giant Donko
-- Food Effect: 1 Hour, All Races
-----------------------------------
-- HP +35
-- STR +7
-- AGI +3
-- INT +4
-- MND +3
-- CHR +2
-- Magic Accuracy +4
-- Magic Attack Bonus +7
-- MP +6% (Cap: 55)
-- Accuracy +15% (Cap: 72)
-- Ranged Accuracy +15% (Cap: 72)
-- Attack +25% (Cap: 150)
-- Ranged Attack +25% (Cap: 150)
-- Demon Killer +6
-- Sleep Resistance +5
-- HP Recovered while healing +6
-- MP Recovered while healing +3
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 3600, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 35)
    effect:addMod(xi.mod.STR, 7)
    effect:addMod(xi.mod.AGI, 3)
    effect:addMod(xi.mod.INT, 4)
    effect:addMod(xi.mod.MND, 3)
    effect:addMod(xi.mod.CHR, 2)
    effect:addMod(xi.mod.MACC, 4)
    effect:addMod(xi.mod.MATT, 7)
    effect:addMod(xi.mod.FOOD_MPP, 6)
    effect:addMod(xi.mod.FOOD_MP_CAP, 55)
    effect:addMod(xi.mod.FOOD_ACCP, 15)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 72)
    effect:addMod(xi.mod.FOOD_RACCP, 15)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 72)
    effect:addMod(xi.mod.FOOD_ATTP, 25)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 150)
    effect:addMod(xi.mod.FOOD_RATTP, 25)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 150)
    effect:addMod(xi.mod.DEMON_KILLER, 6)
    effect:addMod(xi.mod.SLEEPRES, 5)
    effect:addMod(xi.mod.HPHEAL, 6)
    effect:addMod(xi.mod.MPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
