
-----------------------------------
-- ID: 4331
-- Item: imperial_omelette
-- Food Effect: 240Min, All Races
-----------------------------------
-- Non Elvaan Stats
-- Strength 5
-- Dexterity 2
-- Intelligence -3
-- Mind 4
-- Attack % 22
-- Attack Cap 70
-- Ranged ATT % 22
-- Ranged ATT Cap 70
-----------------------------------
-- Elvaan Stats
-- Strength 7
-- Health 30
-- Magic 30
-- Intelligence -1
-- Mind 6
-- Charisma 5
-- Attack % 20 (cap 80)
-- Ranged ATT % 20 (cap 80)
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4331)
end

itemObject.onEffectGain = function(target, effect)
    if
        target:getRace() == xi.race.ELVAAN_M or
        target:getRace() == xi.race.ELVAAN_F
    then
        target:addMod(xi.mod.STR, 5)
        target:addMod(xi.mod.DEX, 2)
        target:addMod(xi.mod.INT, -3)
        target:addMod(xi.mod.MND, 4)
        target:addMod(xi.mod.FOOD_ATTP, 22)
        target:addMod(xi.mod.FOOD_ATT_CAP, 70)
        target:addMod(xi.mod.FOOD_RATTP, 22)
        target:addMod(xi.mod.FOOD_RATT_CAP, 70)
    else
        target:addMod(xi.mod.HP, 30)
        target:addMod(xi.mod.MP, 30)
        target:addMod(xi.mod.STR, 7)
        target:addMod(xi.mod.DEX, 3)
        target:addMod(xi.mod.INT, -1)
        target:addMod(xi.mod.MND, 6)
        target:addMod(xi.mod.CHR, 5)
        target:addMod(xi.mod.FOOD_ATTP, 20)
        target:addMod(xi.mod.FOOD_ATT_CAP, 80)
        target:addMod(xi.mod.FOOD_RATTP, 20)
        target:addMod(xi.mod.FOOD_RATT_CAP, 80)
    end
end

itemObject.onEffectLose = function(target, effect)
    if
        target:getRace() == xi.race.ELVAAN_M or
        target:getRace() == xi.race.ELVAAN_F
    then
        target:delMod(xi.mod.STR, 5)
        target:delMod(xi.mod.DEX, 2)
        target:delMod(xi.mod.INT, -3)
        target:delMod(xi.mod.MND, 4)
        target:delMod(xi.mod.FOOD_ATTP, 22)
        target:delMod(xi.mod.FOOD_ATT_CAP, 70)
        target:delMod(xi.mod.FOOD_RATTP, 22)
        target:delMod(xi.mod.FOOD_RATT_CAP, 70)
    else
        target:delMod(xi.mod.HP, 30)
        target:delMod(xi.mod.MP, 30)
        target:delMod(xi.mod.STR, 7)
        target:delMod(xi.mod.DEX, 3)
        target:delMod(xi.mod.INT, -1)
        target:delMod(xi.mod.MND, 6)
        target:delMod(xi.mod.CHR, 5)
        target:delMod(xi.mod.FOOD_ATTP, 20)
        target:delMod(xi.mod.FOOD_ATT_CAP, 80)
        target:delMod(xi.mod.FOOD_RATTP, 20)
        target:delMod(xi.mod.FOOD_RATT_CAP, 80)
    end
end

return itemObject
