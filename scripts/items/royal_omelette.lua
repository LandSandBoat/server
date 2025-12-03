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
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    local targetRace = target:getRace()

    if
        targetRace == xi.race.ELVAAN_M or
        targetRace == xi.race.ELVAAN_F
    then
        effect:addMod(xi.mod.FOOD_HP, 20)
        effect:addMod(xi.mod.FOOD_MP, 20)
        effect:addMod(xi.mod.STR, 6)
        effect:addMod(xi.mod.DEX, 2)
        effect:addMod(xi.mod.INT, -2)
        effect:addMod(xi.mod.MND, 5)
        effect:addMod(xi.mod.CHR, 4)
        effect:addMod(xi.mod.FOOD_ATTP, 22)
        effect:addMod(xi.mod.FOOD_ATT_CAP, 80)
        effect:addMod(xi.mod.FOOD_RATTP, 22)
        effect:addMod(xi.mod.FOOD_RATT_CAP, 80)
    else
        effect:addMod(xi.mod.STR, 5)
        effect:addMod(xi.mod.DEX, 2)
        effect:addMod(xi.mod.INT, -3)
        effect:addMod(xi.mod.MND, 4)
        effect:addMod(xi.mod.FOOD_ATTP, 20)
        effect:addMod(xi.mod.FOOD_ATT_CAP, 65)
        effect:addMod(xi.mod.FOOD_RATTP, 20)
        effect:addMod(xi.mod.FOOD_RATT_CAP, 65)
    end
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
