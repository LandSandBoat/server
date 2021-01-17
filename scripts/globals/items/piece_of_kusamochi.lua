-----------------------------------------
-- ID: 6262
-- Item: kusamochi
-- Food Effect: 30 Min, All Races
-----------------------------------------
-- HP + 20 (Pet & Master)
-- Vitality + 3 (Pet & Master)
-- Attack + 20% Cap: 72 (Pet & Master) Pet Cap: 113
-- Ranged Attack + 20% Cap: 72 (Pet & Master) Pet Cap: 113
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 6262)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 20)
    target:addMod(tpz.mod.VIT, 3)
    target:addMod(tpz.mod.FOOD_ATTP, 20)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 72)
    target:addMod(tpz.mod.FOOD_RATTP, 20)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 72)
    target:addPetMod(tpz.mod.HP, 20)
    target:addPetMod(tpz.mod.VIT, 3)
    target:addPetMod(tpz.mod.FOOD_ATTP, 20)
    target:addPetMod(tpz.mod.FOOD_ATT_CAP, 113)
    target:addPetMod(tpz.mod.FOOD_RATTP, 20)
    target:addPetMod(tpz.mod.FOOD_RATT_CAP, 113)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 20)
    target:delMod(tpz.mod.VIT, 3)
    target:delMod(tpz.mod.FOOD_ATTP, 20)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 72)
    target:delMod(tpz.mod.FOOD_RATTP, 20)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 72)
    target:delPetMod(tpz.mod.HP, 20)
    target:delPetMod(tpz.mod.VIT, 3)
    target:delPetMod(tpz.mod.FOOD_ATTP, 20)
    target:delPetMod(tpz.mod.FOOD_ATT_CAP, 113)
    target:delPetMod(tpz.mod.FOOD_RATTP, 20)
    target:delPetMod(tpz.mod.FOOD_RATT_CAP, 113)
end

return item_object
