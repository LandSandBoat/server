-----------------------------------
-- ID: 5583
-- Item: plate_of_patlican_salata_+1
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- Agility 5
-- Vitality -2
-- Evasion +7
-- hHP +3
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5583)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, 5)
    target:addMod(xi.mod.VIT, -2)
    target:addMod(xi.mod.EVA, 7)
    target:addMod(xi.mod.HPHEAL, 3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, 5)
    target:delMod(xi.mod.VIT, -2)
    target:delMod(xi.mod.EVA, 7)
    target:delMod(xi.mod.HPHEAL, 3)
end

return item_object
