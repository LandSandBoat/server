-----------------------------------
-- ID: 4404
-- Item: roast_trout
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 3
-- Mind -1
-- Ranged ATT % 14 (cap 50)
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4404)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.MND, -1)
    target:addMod(xi.mod.RATTP, 14)
    target:addMod(xi.mod.RATT_CAP, 50)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.MND, -1)
    target:delMod(xi.mod.RATTP, 14)
    target:delMod(xi.mod.RATT_CAP, 50)
end

return item_object
