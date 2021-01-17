-----------------------------------------
-- ID: 4336
-- Item: sweet_baked_apple
-- Food Effect: 1hour, All Races
-----------------------------------------
-- Magic Points 25
-- Intelligence 4
-- MP Recovered While Healing 2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4336)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MP, 25)
    target:addMod(tpz.mod.INT, 4)
    target:addMod(tpz.mod.MPHEAL, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MP, 25)
    target:delMod(tpz.mod.INT, 4)
    target:delMod(tpz.mod.MPHEAL, 2)
end

return item_object
