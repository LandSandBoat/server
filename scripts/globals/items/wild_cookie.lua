-----------------------------------------
-- ID: 4577
-- Item: wild_cookie
-- Food Effect: 5Min, All Races
-----------------------------------------
-- Aquan killer +12
-- Silence resistance +12
-- MP recovered while healing +5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 4577)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.AQUAN_KILLER, 12)
    target:addMod(tpz.mod.SILENCERES, 12)
    target:addMod(tpz.mod.MPHEAL, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.AQUAN_KILLER, 12)
    target:delMod(tpz.mod.SILENCERES, 12)
    target:delMod(tpz.mod.MPHEAL, 5)
end

return item_object
