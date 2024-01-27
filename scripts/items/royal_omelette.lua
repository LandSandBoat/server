-----------------------------------
-- ID: 4564
-- Item: royal_omelette
-- Food Effect: 180Min, All Races
-----------------------------------
-- Strength 5
-- Dexterity 2
-- Intelligence -3
-- Mind 4
-- Attack % 20 (cap 65)
-- Ranged Attack % 20 (cap 65)
-----------------------------------
-- IF ELVAAN ONLY
-- HP 20
-- MP 20
-- Strength 6
-- Dexterity 2
-- Intelligence -2
-- Mind 5
-- Charisma 4
-- Attack % 22
-- Attack Cap 80
-- Ranged ATT % 22
-- Ranged ATT Cap 80
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4564)
end

itemObject.onEffectGain = function(target, effect)
    if
        target:getRace() == xi.race.ELVAAN_M or
        target:getRace() == xi.race.ELVAAN_F
    then
        target:addMod(xi.mod.HP, 20)
        target:addMod(xi.mod.MP, 20)
        target:addMod(xi.mod.STR, 6)
        target:addMod(xi.mod.DEX, 2)
        target:addMod(xi.mod.INT, -2)
        target:addMod(xi.mod.MND, 5)
        target:addMod(xi.mod.CHR, 4)
        target:addMod(xi.mod.FOOD_ATTP, 22)
        target:addMod(xi.mod.FOOD_ATT_CAP, 80)
        target:addMod(xi.mod.FOOD_RATTP, 22)
        target:addMod(xi.mod.FOOD_RATT_CAP, 80)
    else
        target:addMod(xi.mod.STR, 5)
        target:addMod(xi.mod.DEX, 2)
        target:addMod(xi.mod.INT, -3)
        target:addMod(xi.mod.MND, 4)
        target:addMod(xi.mod.FOOD_ATTP, 20)
        target:addMod(xi.mod.FOOD_ATT_CAP, 65)
        target:addMod(xi.mod.FOOD_RATTP, 20)
        target:addMod(xi.mod.FOOD_RATT_CAP, 65)
    end
end

itemObject.onEffectLose = function(target, effect)
    if
        target:getRace() == xi.race.ELVAAN_M or
        target:getRace() == xi.race.ELVAAN_F
    then
        target:delMod(xi.mod.HP, 20)
        target:delMod(xi.mod.MP, 20)
        target:delMod(xi.mod.STR, 6)
        target:delMod(xi.mod.DEX, 2)
        target:delMod(xi.mod.INT, -2)
        target:delMod(xi.mod.MND, 5)
        target:delMod(xi.mod.CHR, 4)
        target:delMod(xi.mod.FOOD_ATTP, 22)
        target:delMod(xi.mod.FOOD_ATT_CAP, 80)
        target:delMod(xi.mod.FOOD_RATTP, 22)
        target:delMod(xi.mod.FOOD_RATT_CAP, 80)
    else
        target:delMod(xi.mod.STR, 5)
        target:delMod(xi.mod.DEX, 2)
        target:delMod(xi.mod.INT, -3)
        target:delMod(xi.mod.MND, 4)
        target:delMod(xi.mod.FOOD_ATTP, 20)
        target:delMod(xi.mod.FOOD_ATT_CAP, 65)
        target:delMod(xi.mod.FOOD_RATTP, 20)
        target:delMod(xi.mod.FOOD_RATT_CAP, 65)
    end
end

return itemObject
