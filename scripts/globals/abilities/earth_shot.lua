-----------------------------------
-- Ability: Earth Shot
-- Consumes a Earth Card to enhance earth-based debuffs. Deals earth-based magic damage
-- Rasp Effect: Enhanced DoT and DEX-, Slow Effect +10%
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/magic")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    --ranged weapon/ammo: You do not have an appropriate ranged weapon equipped.
    --no card: <name> cannot perform that action.
    if player:getWeaponSkillType(tpz.slot.RANGED) ~= tpz.skill.MARKSMANSHIP or player:getWeaponSkillType(tpz.slot.AMMO) ~= tpz.skill.MARKSMANSHIP then
        return 216, 0
    end
    if player:hasItem(2179, 0) or player:hasItem(2974, 0) then
        return 0, 0
    else
        return 71, 0
    end
end

ability_object.onUseAbility = function(player, target, ability, action)
    local params = {}
    params.includemab = true
    local dmg = (2 * (player:getRangedDmg() + player:getAmmoDmg()) + player:getMod(tpz.mod.QUICK_DRAW_DMG)) * (1 + player:getMod(tpz.mod.QUICK_DRAW_DMG_PERCENT) / 100)
    dmg  = addBonusesAbility(player, tpz.magic.ele.EARTH, target, dmg, params)
    local bonusAcc = player:getStat(tpz.mod.AGI) / 2 + player:getMerit(tpz.merit.QUICK_DRAW_ACCURACY) + player:getMod(tpz.mod.QUICK_DRAW_MACC)
    dmg = dmg * applyResistanceAbility(player, target, tpz.magic.ele.EARTH, tpz.skill.NONE, bonusAcc)
    dmg = adjustForTarget(target, dmg, tpz.magic.ele.EARTH)

    params.targetTPMult = 0 -- Quick Draw does not feed TP
    dmg = takeAbilityDamage(target, player, params, true, dmg, tpz.attackType.MAGICAL, tpz.damageType.EARTH, tpz.slot.RANGED, 1, 0, 0, 0, action, nil)

    if dmg > 0 then
        local effects = {}
        local rasp = target:getStatusEffect(tpz.effect.RASP)
        if rasp ~= nil then
            table.insert(effects, rasp)
        end

        local threnody = target:getStatusEffect(tpz.effect.THRENODY)
        if threnody ~= nil and threnody:getSubPower() == tpz.mod.THUNDERRES then
            table.insert(effects, threnody)
        end

        local slow = target:getStatusEffect(tpz.effect.SLOW)
        if slow ~= nil then
            table.insert(effects, slow)
        end

        if #effects > 0 then
            local effect = effects[math.random(#effects)]
            local duration = effect:getDuration()
            local startTime = effect:getStartTime()
            local tick = effect:getTick()
            local power = effect:getPower()
            local subpower = effect:getSubPower()
            local tier = effect:getTier()
            local effectId = effect:getType()
            local subId = effect:getSubType()
            power = power * 1.2
            target:delStatusEffectSilent(effectId)
            target:addStatusEffect(effectId, power, tick, duration, subId, subpower, tier)
            local newEffect = target:getStatusEffect(effectId)
            newEffect:setStartTime(startTime)
        end
    end

    local del = player:delItem(2179, 1) or player:delItem(2974, 1)
    target:updateClaim(player)
    return dmg
end

return ability_object
