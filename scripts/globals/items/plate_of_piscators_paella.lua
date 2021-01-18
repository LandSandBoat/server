-----------------------------------
-- ID: 5969
-- Item: Plate of Piscator's Paella
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- HP 45
-- Dexterity 6
-- Accuracy % 16 (cap 85)
-- Undead Killer 6
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5969)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 45)
    target:addMod(tpz.mod.DEX, 6)
    target:addMod(tpz.mod.FOOD_ACCP, 16)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 85)
    target:addMod(tpz.mod.UNDEAD_KILLER, 6)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 45)
    target:delMod(tpz.mod.DEX, 6)
    target:delMod(tpz.mod.FOOD_ACCP, 16)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 85)
    target:delMod(tpz.mod.UNDEAD_KILLER, 6)
end

return item_object
