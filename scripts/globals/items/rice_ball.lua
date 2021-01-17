-----------------------------------------
-- ID: 4405
-- Item: Rice Ball
-- Food Effect: 30Min, All Races
-----------------------------------------
-- HP 10,
-- Vit +2
-- Dex -1
-- hHP +1
-- Effect with enhancing equipment (Note: these are latents on gear with the effect)
-- Def +50
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4405)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 10)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.DEX, -1)
    target:addMod(tpz.mod.HPHEAL, 1)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 10)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.DEX, -1)
    target:delMod(tpz.mod.HPHEAL, 1)
end

return item_object
