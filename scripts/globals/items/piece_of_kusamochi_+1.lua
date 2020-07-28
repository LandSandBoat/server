-----------------------------------------
-- ID: 6263
-- Item: kusamochi+1
-- Food Effect: 60 Min, All Races
-----------------------------------------
-- HP + 30 (Pet & Master)
-- Vitality + 4 (Pet & Master)
-- Attack + 21% Cap: 77 (Pet & Master) Pet Cap: 120
-- Ranged Attack + 21% Cap: 77 (Pet & Master) Pet Cap: 120
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 6263)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 30)
    target:addMod(tpz.mod.VIT, 4)
    target:addMod(tpz.mod.FOOD_ATTP, 21)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 77)
    target:addMod(tpz.mod.FOOD_RATTP, 21)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 77)
    target:addPetMod(tpz.mod.HP, 30)
    target:addPetMod(tpz.mod.VIT, 4)
    target:addPetMod(tpz.mod.FOOD_ATTP, 21)
    target:addPetMod(tpz.mod.FOOD_ATT_CAP, 120)
    target:addPetMod(tpz.mod.FOOD_RATTP, 21)
    target:addPetMod(tpz.mod.FOOD_RATT_CAP, 120)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 30)
    target:delMod(tpz.mod.VIT, 4)
    target:delMod(tpz.mod.FOOD_ATTP, 21)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 77)
    target:delMod(tpz.mod.FOOD_RATTP, 21)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 77)
    target:delPetMod(tpz.mod.HP, 30)
    target:delPetMod(tpz.mod.VIT, 4)
    target:delPetMod(tpz.mod.FOOD_ATTP, 21)
    target:delPetMod(tpz.mod.FOOD_ATT_CAP, 120)
    target:delPetMod(tpz.mod.FOOD_RATTP, 21)
    target:delPetMod(tpz.mod.FOOD_RATT_CAP, 120)
end
