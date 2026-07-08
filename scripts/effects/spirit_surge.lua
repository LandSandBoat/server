-----------------------------------
-- xi.effect.SPIRIT_SURGE
-----------------------------------
---@type TEffect
local effectObject = {}

-- https://www.bg-wiki.com/ffxi/Spirit_Surge

effectObject.onEffectGain = function(target, effect)
    -- The dragoon's MAX HP increases by % of wyvern MaxHP
    effect:addMod(xi.mod.HP, effect:getPower())
    target:updateHealth()

    -- The dragoon gets a Strength boost relative to his level
    effect:addMod(xi.mod.STR, effect:getSubPower())

    -- The dragoon gets a 50 Accuracy boost
    effect:addMod(xi.mod.ACC, 50)

    -- Wyvern levelup bonuses appear to be transferred as if the wyvern was max level:
    -- Does this also give the 10% all hits WSD and the 15% DA with job point gifts?
    effect:addMod(xi.mod.ATTP, 25)
    effect:addMod(xi.mod.DEFP, 25)

    -- The dragoon gets 25% Haste (see http://wiki.bluegartr.com/bg/Job_Ability_Haste for haste calculation)
    effect:addMod(xi.mod.HASTE_ABILITY, 2500)

    -- DMG + 1 * JP
    effect:addMod(xi.mod.MAIN_DMG_RATING, target:getJobPointLevel(xi.jp.SPIRIT_SURGE_EFFECT))
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
