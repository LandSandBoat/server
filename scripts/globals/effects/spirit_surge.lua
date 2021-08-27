-----------------------------------
-- xi.effect.SPIRIT_SURGE
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    -- The dragoon's MAX HP increases by % of wyvern MaxHP
    target:addMod(xi.mod.HP, effect:getPower())
    target:updateHealth()
    target:addHP(effect:getPower())

    -- The dragoon gets a Strength boost relative to his level
    target:addMod(xi.mod.STR, effect:getSubPower())

    -- The dragoon gets a 50 Accuracy boost
    target:addMod(xi.mod.ACC, 50)

    -- The dragoon gets 25% Haste (see http://wiki.bluegartr.com/bg/Job_Ability_Haste for haste calculation)
    target:addMod(xi.mod.HASTE_ABILITY, 2500)

    -- DMG + 1 * JP
    target:addMod(xi.mod.MAIN_DMG_RATING, target:getJobPointLevel(xi.jp.SPIRIT_SURGE_EFFECT))
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    -- The dragoon's MAX HP returns to normal (when the MAXHP boost in onEffectGain() gets implemented)
    target:delMod(xi.mod.HP, effect:getPower())

    -- The dragoon loses the Strength boost
    target:delMod(xi.mod.STR, effect:getSubPower())

    -- The dragoon loses the 50 Accuracy boost
    target:delMod(xi.mod.ACC, 50)

    -- The dragoon loses 25% Haste
    target:delMod(xi.mod.HASTE_ABILITY, 2500)

    target:delMod(xi.mod.MAIN_DMG_RATING, target:getJobPointLevel(xi.jp.SPIRIT_SURGE_EFFECT))
end

return effect_object
