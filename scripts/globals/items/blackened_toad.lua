-----------------------------------------
-- ID: 4599
-- Item: Blackened Toad
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Dexterity 2
-- Agility 2
-- Mind -1
-- Poison Resist 4
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4599)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEX, 2)
    target:addMod(tpz.mod.AGI, 2)
    target:addMod(tpz.mod.MND, -1)
    target:addMod(tpz.mod.POISONRES, 4)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEX, 2)
    target:delMod(tpz.mod.AGI, 2)
    target:delMod(tpz.mod.MND, -1)
    target:delMod(tpz.mod.POISONRES, 4)
end

return item_object
