-----------------------------------
-- Ability: Dark Shot
-- Consumes a Dark Card to enhance dark-based debuffs. Additional effect: Dark-based Dispel
-- Bio Effect: Attack Down Effect +5% and DoT + 3
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    --ranged weapon/ammo: You do not have an appropriate ranged weapon equipped.
    --no card: <name> cannot perform that action.
    if
        player:getWeaponSkillType(xi.slot.RANGED) ~= xi.skill.MARKSMANSHIP or
        player:getWeaponSkillType(xi.slot.AMMO) ~= xi.skill.MARKSMANSHIP
    then
        return 216, 0
    end

    if player:hasItem(2183, 0) or player:hasItem(2974, 0) then
        return 0, 0
    else
        return 71, 0
    end
end

abilityObject.onUseAbility = function(player, target, ability)
    local duration = 60
    local bonusAcc = player:getStat(xi.mod.AGI) / 2 + player:getMerit(xi.merit.QUICK_DRAW_ACCURACY) + player:getMod(xi.mod.QUICK_DRAW_MACC)
    local resist   = applyResistanceAbility(player, target, xi.magic.ele.DARK, xi.skill.NONE, bonusAcc)

    if resist < 0.25 then
        ability:setMsg(xi.msg.basic.JA_MISS_2) -- resist message
        return 0
    end

    duration = duration * resist

    local effects = {}

    local bio = target:getStatusEffect(xi.effect.BIO)
    if bio ~= nil then
        table.insert(effects, bio)
    end

    local blind = target:getStatusEffect(xi.effect.BLINDNESS)
    if blind ~= nil then
        table.insert(effects, blind)
    end

    local threnody = target:getStatusEffect(xi.effect.THRENODY)
    if threnody ~= nil and threnody:getSubPower() == xi.mod.LIGHT_MEVA then
        table.insert(effects, threnody)
    end

    if #effects > 0 then
        local effect = effects[math.random(1, #effects)]
        -- TODO: duration here overwrites all previous values, this logic needs to be verified
        duration = effect:getDuration()
        local startTime = effect:getStartTime()
        local tick      = effect:getTick()
        local power     = effect:getPower()
        local subpower  = effect:getSubPower()
        local tier      = effect:getTier()
        local effectId  = effect:getType()
        local subId     = effect:getSubType()
        power    = power * 1.5
        subpower = subpower * 1.5
        target:delStatusEffectSilent(effectId)
        target:addStatusEffect(effectId, power, tick, duration, subId, subpower, tier)
        local newEffect = target:getStatusEffect(effectId)
        newEffect:setStartTime(startTime)
    end

    ability:setMsg(xi.msg.basic.JA_REMOVE_EFFECT_2)

    local dispelledEffect = target:dispelStatusEffect()
    if dispelledEffect == xi.effect.NONE then
        -- no effect
        ability:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
    end

    local _ = player:delItem(2183, 1) or player:delItem(2974, 1)
    target:updateClaim(player)
    return dispelledEffect
end

return abilityObject
