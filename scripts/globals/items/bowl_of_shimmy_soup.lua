-----------------------------------
-- ID: 5931
-- Item: Bowl of Shimmy Soup
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- MP 32
-- Mind 5
-- HP Recovered While Healing 5
-- Enmity -5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5931)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MP, 32)
    target:addMod(tpz.mod.MND, 5)
    target:addMod(tpz.mod.HPHEAL, 5)
    target:addMod(tpz.mod.ENMITY, -5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MP, 32)
    target:delMod(tpz.mod.MND, 5)
    target:delMod(tpz.mod.HPHEAL, 5)
    target:delMod(tpz.mod.ENMITY, -5)
end

return item_object
