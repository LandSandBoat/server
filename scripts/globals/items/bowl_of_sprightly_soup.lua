-----------------------------------
-- ID: 5930
-- Item: Bowl of Sprightly Soup
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- MP 30
-- Mind 4
-- HP Recovered While Healing 4
-- Enmity -4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5930)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MP, 30)
    target:addMod(tpz.mod.MND, 4)
    target:addMod(tpz.mod.HPHEAL, 4)
    target:addMod(tpz.mod.ENMITY, -4)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MP, 30)
    target:delMod(tpz.mod.MND, 4)
    target:delMod(tpz.mod.HPHEAL, 4)
    target:delMod(tpz.mod.ENMITY, -4)
end

return item_object
