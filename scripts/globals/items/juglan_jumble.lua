-----------------------------------------
-- ID: 5923
-- Item: Juglan Jumble
-- Food Effect: 5 Min, All Races
-----------------------------------------
-- HP Healing 5
-- MP Healing 8
-- Bird Killer 12
-- Resist Paralyze 12
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 5923)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HPHEAL, 5)
    target:addMod(tpz.mod.MPHEAL, 8)
    target:addMod(tpz.mod.BIRD_KILLER, 12)
    target:addMod(tpz.mod.PARALYZERES, 12)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HPHEAL, 5)
    target:delMod(tpz.mod.MPHEAL, 8)
    target:delMod(tpz.mod.BIRD_KILLER, 12)
    target:delMod(tpz.mod.PARALYZERES, 12)
end

return item_object
