-----------------------------------
-- ID: 4525
-- Item: pumpkin_pie_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Magic 45
-- Intelligence 4
-- Charisma -1
-- MP Recovered While Healing 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4525)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MP, 45)
    target:addMod(tpz.mod.INT, 4)
    target:addMod(tpz.mod.CHR, -1)
    target:addMod(tpz.mod.MPHEAL, 1)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MP, 45)
    target:delMod(tpz.mod.INT, 4)
    target:delMod(tpz.mod.CHR, -1)
    target:delMod(tpz.mod.MPHEAL, 1)
end

return item_object
