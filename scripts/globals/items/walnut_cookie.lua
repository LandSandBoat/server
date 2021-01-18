-----------------------------------
-- ID: 5922
-- Item: Walnut Cookie
-- Food Effect: 3 Min, All Races
-----------------------------------
-- HP Healing 3
-- MP Healing 6
-- Bird Killer 10
-- Resist Paralyze 10
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 180, 5922)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HPHEAL, 3)
    target:addMod(tpz.mod.MPHEAL, 6)
    target:addMod(tpz.mod.BIRD_KILLER, 10)
    target:addMod(tpz.mod.PARALYZERES, 10)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HPHEAL, 3)
    target:delMod(tpz.mod.MPHEAL, 6)
    target:delMod(tpz.mod.BIRD_KILLER, 10)
    target:delMod(tpz.mod.PARALYZERES, 10)
end

return item_object
