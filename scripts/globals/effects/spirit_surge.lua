-----------------------------------
-- tpz.effect.SPIRIT_SURGE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    -- The dragoon's MAX HP increases by % of wyvern MaxHP
    target:addMod(tpz.mod.HP, effect:getPower())
    target:updateHealth()
    target:addHP(effect:getPower())

    -- The dragoon gets a Strength boost relative to his level
    target:addMod(tpz.mod.STR, effect:getSubPower())

    -- The dragoon gets a 50 Accuracy boost
    target:addMod(tpz.mod.ACC, 50)

    -- The dragoon gets 25% Haste (see http://wiki.bluegartr.com/bg/Job_Ability_Haste for haste calculation)
    target:addMod(tpz.mod.HASTE_ABILITY, 2500)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    -- The dragoon's MAX HP returns to normal (when the MAXHP boost in onEffectGain() gets implemented)
    target:delMod(tpz.mod.HP, effect:getPower())

    -- The dragoon loses the Strength boost
    target:delMod(tpz.mod.STR, effect:getSubPower())

    -- The dragoon loses the 50 Accuracy boost
    target:delMod(tpz.mod.ACC, 50)

    -- The dragoon loses 25% Haste
    target:delMod(tpz.mod.HASTE_ABILITY, 2500)
end

return effect_object
