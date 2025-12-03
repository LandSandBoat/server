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
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    local targetRace = target:getRace()

    if
        targetRace == xi.race.ELVAAN_M or
        targetRace == xi.race.ELVAAN_F
    then
        effect:addMod(xi.mod.STR, 5)
        effect:addMod(xi.mod.DEX, 2)
        effect:addMod(xi.mod.INT, -3)
        effect:addMod(xi.mod.MND, 4)
        effect:addMod(xi.mod.FOOD_ATTP, 22)
        effect:addMod(xi.mod.FOOD_ATT_CAP, 70)
        effect:addMod(xi.mod.FOOD_RATTP, 22)
        effect:addMod(xi.mod.FOOD_RATT_CAP, 70)
    else
        effect:addMod(xi.mod.FOOD_HP, 30)
        effect:addMod(xi.mod.FOOD_MP, 30)
        effect:addMod(xi.mod.STR, 7)
        effect:addMod(xi.mod.DEX, 3)
        effect:addMod(xi.mod.INT, -1)
        effect:addMod(xi.mod.MND, 6)
        effect:addMod(xi.mod.CHR, 5)
        effect:addMod(xi.mod.FOOD_ATTP, 20)
        effect:addMod(xi.mod.FOOD_ATT_CAP, 80)
        effect:addMod(xi.mod.FOOD_RATTP, 20)
        effect:addMod(xi.mod.FOOD_RATT_CAP, 80)
    end
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
