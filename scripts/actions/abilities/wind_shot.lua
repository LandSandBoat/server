-----------------------------------
-- Ability: Wind Shot
-- Consumes a Wind Card to enhance wind-based debuffs. Deals wind-based magic damage
-- Choke Effect: Enhanced DoT and VIT-
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
        player:hasItem(xi.item.WIND_CARD, 0) or
        player:hasItem(xi.item.TRUMP_CARD, 0)
    then
        ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.QUICK_DRAW_RECAST)))
        return 0, 0
    else
        return 71, 0
    end
end

abilityObject.onUseAbility = function(player, target, ability, action)
    local params = {}
    params.includemab = true

    local dmg = (2 * (player:getRangedDmg() + player:getAmmoDmg()) + player:getMod(xi.mod.QUICK_DRAW_DMG)) * (1 + player:getMod(xi.mod.QUICK_DRAW_DMG_PERCENT) / 100)
    dmg       = dmg + 2 * player:getJobPointLevel(xi.jp.QUICK_DRAW_EFFECT)
    dmg       = addBonusesAbility(player, xi.element.WIND, target, dmg, params)

    local bonusAcc = player:getStat(xi.mod.AGI) / 2 + player:getMerit(xi.merit.QUICK_DRAW_ACCURACY) + player:getMod(xi.mod.QUICK_DRAW_MACC)
    dmg            = dmg * applyResistanceAbility(player, target, xi.element.WIND, xi.skill.NONE, bonusAcc)
    dmg            = adjustForTarget(target, dmg, xi.element.WIND)

    params.targetTPMult = 0 -- Quick Draw does not feed TP
    dmg                 = xi.ability.takeDamage(target, player, params, true, dmg, xi.attackType.MAGICAL, xi.damageType.WIND, xi.slot.RANGED, 1, 0, 0, 0, action, nil)

    if dmg > 0 then
        local effects = {}

        local choke = target:getStatusEffect(xi.effect.CHOKE)

        if choke ~= nil then
            table.insert(effects, choke)
        end

        local threnody = target:getStatusEffect(xi.effect.THRENODY)

        if threnody ~= nil and threnody:getSubPower() == xi.mod.EARTH_MEVA then
            table.insert(effects, threnody)
        end

        --TODO: Frightful Roar
        --[[local frightfulRoar = target:getStatusEffect(xi.effect.)
        if (frightfulRoar ~= nil) then
            effects[counter] = frightfulRoar
            counter = counter + 1
        end]]

        if #effects > 0 then
            local effect    = effects[math.random(1, #effects)]
            local duration  = effect:getDuration()
            local startTime = effect:getStartTime()
            local tick      = effect:getTick()
            local power     = effect:getPower()
            local subpower  = effect:getSubPower()
            local tier      = effect:getTier()
            local effectId  = effect:getEffectType()
            local subId     = effect:getSubType()

            power = power * 1.2
            target:delStatusEffectSilent(effectId)
            target:addStatusEffect(effectId, power, tick, duration, subId, subpower, tier)

            local newEffect = target:getStatusEffect(effectId)
            newEffect:setStartTime(startTime)
        end
    end

    local _ = player:delItem(xi.item.WIND_CARD, 1) or player:delItem(xi.item.TRUMP_CARD, 1)
    target:updateClaim(player)

    return dmg
end

return abilityObject
