-----------------------------------
-- ID: 4492
-- Item: bowl_of_puls
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- Vitality 2
-- Dexterity -1
-- HP Recovered While Healing 3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4492)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.DEX, -1)
    target:addMod(tpz.mod.HPHEAL, 3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.DEX, -1)
    target:delMod(tpz.mod.HPHEAL, 3)
end

return item_object
