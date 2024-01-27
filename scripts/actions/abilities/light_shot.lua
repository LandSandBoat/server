-----------------------------------
-- Ability: Light Shot
-- Consumes a Light Card to enhance light-based debuffs. Additional effect: Light-based Sleep
-- Dia Effect: Defense Down Effect +5% and DoT + 1
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

    if
        player:hasItem(xi.item.LIGHT_CARD, 0) or
        player:hasItem(xi.item.TRUMP_CARD, 0)
    then
        return 0, 0
    else
        return 71, 0
    end
end

abilityObject.onUseAbility = function(player, target, ability, action)
    action:setRecast(math.max(0, action:getRecast() - player:getMod(xi.mod.QUICK_DRAW_RECAST)))
    local duration = 60
    local bonusAcc = player:getStat(xi.mod.AGI) / 2 + player:getMerit(xi.merit.QUICK_DRAW_ACCURACY) + player:getMod(xi.mod.QUICK_DRAW_MACC)
    local resist   = applyResistanceAbility(player, target, xi.element.LIGHT, xi.skill.NONE, bonusAcc)

    if resist < 0.5 then
        ability:setMsg(xi.msg.basic.JA_MISS_2) -- resist message
        return xi.effect.SLEEP_I
    end

    duration = duration * resist

    local effects = {}

    local dia = target:getStatusEffect(xi.effect.DIA)

    if dia ~= nil then
        table.insert(effects, dia)
    end

    local threnody = target:getStatusEffect(xi.effect.THRENODY)

    if threnody ~= nil and threnody:getSubPower() == xi.mod.DARK_MEVA then
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
        local effectId  = effect:getEffectType()
        local subId     = effect:getSubType()
        power    = power * 1.5
        subpower = subpower * 1.5
        target:delStatusEffectSilent(effectId)
        target:addStatusEffect(effectId, power, tick, duration, subId, subpower, tier)

        local newEffect = target:getStatusEffect(effectId)
        newEffect:setStartTime(startTime)
    end

    if target:addStatusEffect(xi.effect.SLEEP_I, 1, 0, duration) then
        ability:setMsg(xi.msg.basic.JA_ENFEEB_IS)
    else
        ability:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
    end

    local _ = player:delItem(xi.item.LIGHT_CARD, 1) or player:delItem(xi.item.TRUMP_CARD, 1)
    target:updateClaim(player)

    return xi.effect.SLEEP_I
end

return abilityObject
