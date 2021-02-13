-----------------------------------
-- ID: 6498
-- Item: Bunch of Fortune Fruits
-- Food Effect: 30Min, All Races
-----------------------------------
-- Charisma +7
-- may have unknown hidden effects
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 6498)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.CHR, 7)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.CHR, 7)
end

return item_object
