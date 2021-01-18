-----------------------------------
-- ID: 5908
-- Item: Butterpear
-- Food Effect: 5Min, All Races
-----------------------------------
-- Agility +4
-- Vitality +1
-- Resist Amnesia +20
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 5908)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.AGI, 4)
    target:addMod(tpz.mod.VIT, 1)
    target:addMod(tpz.mod.AMNESIARES, 20)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.AGI, 4)
    target:delMod(tpz.mod.VIT, 1)
    target:delMod(tpz.mod.AMNESIARES, 20)
end

return item_object
