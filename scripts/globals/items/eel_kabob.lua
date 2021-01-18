-----------------------------------
-- ID: 4457
-- Item: eel_kabob
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 4
-- Mind -3
-- Evasion 5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4457)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEX, 4)
    target:addMod(tpz.mod.MND, -3)
    target:addMod(tpz.mod.EVA, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEX, 4)
    target:delMod(tpz.mod.MND, -3)
    target:delMod(tpz.mod.EVA, 5)
end

return item_object
