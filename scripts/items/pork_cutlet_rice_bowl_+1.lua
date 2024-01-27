-----------------------------------
-- ID: 6407
-- Item: pork_cutlet_rice_bowl_+1
-- Food Effect: 240Min, All Races
-----------------------------------
-- HP +65
-- MP +65
-- STR +8
-- VIT +4
-- AGI +6
-- INT -8
-- Fire resistance +21
-- Attack +24% (cap 130)
-- Ranged Attack +24% (cap 130)
-- Store TP +5
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 6407)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 65)
    target:addMod(xi.mod.MP, 65)
    target:addMod(xi.mod.STR, 8)
    target:addMod(xi.mod.VIT, 4)
    target:addMod(xi.mod.AGI, 6)
    target:addMod(xi.mod.INT, -8)
    target:addMod(xi.mod.FIRE_MEVA, 21)
    target:addMod(xi.mod.FOOD_ATTP, 24)
    target:addMod(xi.mod.FOOD_ATT_CAP, 130)
    target:addMod(xi.mod.FOOD_RATTP, 24)
    target:addMod(xi.mod.FOOD_RATT_CAP, 130)
    target:addMod(xi.mod.STORETP, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 65)
    target:delMod(xi.mod.MP, 65)
    target:delMod(xi.mod.STR, 8)
    target:delMod(xi.mod.VIT, 4)
    target:delMod(xi.mod.AGI, 6)
    target:delMod(xi.mod.INT, -8)
    target:delMod(xi.mod.FIRE_MEVA, 21)
    target:delMod(xi.mod.FOOD_ATTP, 24)
    target:delMod(xi.mod.FOOD_ATT_CAP, 130)
    target:delMod(xi.mod.FOOD_RATTP, 24)
    target:delMod(xi.mod.FOOD_RATT_CAP, 130)
    target:delMod(xi.mod.STORETP, 5)
end

return itemObject
