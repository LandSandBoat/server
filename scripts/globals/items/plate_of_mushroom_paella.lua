-----------------------------------
-- ID: 5970
-- Item: Plate of Mushroom Paella
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- HP 40
-- Strength -1
-- Mind 5
-- Magic Accuracy 5
-- Undead Killer 5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5970)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 40)
    target:addMod(tpz.mod.STR, -1)
    target:addMod(tpz.mod.MND, 5)
    target:addMod(tpz.mod.MACC, 5)
    target:addMod(tpz.mod.UNDEAD_KILLER, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 40)
    target:delMod(tpz.mod.STR, -1)
    target:delMod(tpz.mod.MND, 5)
    target:delMod(tpz.mod.MACC, 5)
    target:delMod(tpz.mod.UNDEAD_KILLER, 5)
end

return item_object
