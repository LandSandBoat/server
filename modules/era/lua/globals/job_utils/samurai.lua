-----------------------------------
-- Module: Samurai Job Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_job_utils_samurai'

-- If Abyssea or later is enabled, no changes.
if xi.module.isContentEnabled('ABYSSEA') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

-- Warding Circle: Revert duration from 3 minutes to 1 minute
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
m:addOverride('xi.job_utils.samurai.useWardingCircle', function(player, target, ability)
    local duration = 60 + player:getMod(xi.mod.WARDING_CIRCLE_DURATION)
    local power    = 15

    if player:getMainJob() ~= xi.job.SAM then
        power = 5
    end

    power = power + player:getMod(xi.mod.WARDING_CIRCLE_POTENCY)

    target:addStatusEffect(xi.effect.WARDING_CIRCLE, { power = power, duration = duration, origin = player })

    return xi.effect.WARDING_CIRCLE
end)

-- Blade Bash: Apply merit recast reduction, remove extra plague duration from merits
m:addOverride('xi.job_utils.samurai.useBladeBash', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.BLADE_BASH) - 150
    action:setRecast(action:getRecast() - recastReduction)

    -- Damage
    -- TODO: Verify damage formula and DRK interaction
    local jobLevel = utils.getActiveJobLevel(player, xi.job.DRK)
    local damage   = math.floor((jobLevel + 11) / 4 + player:getMod(xi.mod.WEAPON_BASH))
    damage = utils.handleStoneskin(target, damage)
    target:takeDamage(damage, player, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    target:updateEnmityFromDamage(player, damage)

    -- Stun
    if
        not xi.data.statusEffect.isTargetImmune(target, xi.effect.STUN, xi.element.THUNDER) and
        not xi.data.statusEffect.isTargetResistant(player, target, xi.effect.STUN) and
        not xi.data.statusEffect.isEffectNullified(target, xi.effect.STUN, 0)
    then
        local resistanceRate = xi.combat.magicHitRate.calculateResistRate(player, target, 0, 0, xi.skillRank.A_PLUS, xi.element.THUNDER, xi.mod.INT, xi.effect.STUN, 0)
        if xi.data.statusEffect.isResistRateSuccessfull(xi.effect.STUN, resistanceRate, 0) then
            target:addStatusEffect(xi.effect.STUN, { power = 1, duration = 6 * resistanceRate, origin = player })
        end
    end

    -- Plague
    if
        not xi.data.statusEffect.isTargetImmune(target, xi.effect.PLAGUE, xi.element.FIRE) and
        not xi.data.statusEffect.isTargetResistant(player, target, xi.effect.PLAGUE) and
        not xi.data.statusEffect.isEffectNullified(target, xi.effect.PLAGUE, 0)
    then
        local resistanceRate = xi.combat.magicHitRate.calculateResistRate(player, target, 0, 0, xi.skillRank.A_PLUS, xi.element.FIRE, xi.mod.INT, xi.effect.PLAGUE, 0)
        if xi.data.statusEffect.isResistRateSuccessfull(xi.effect.PLAGUE, resistanceRate, 0) then
            target:addStatusEffect(xi.effect.PLAGUE, { power = 5, duration = 15 * resistanceRate, origin = player })
        end
    end

    -- Animation
    local animationTable =
    {
        -- [weapon type] = animation ID
        [xi.skill.GREAT_SWORD ] = 201,
        [xi.skill.GREAT_KATANA] = 201,
        [xi.skill.GREAT_AXE   ] = 202,
        [xi.skill.SCYTHE      ] = 202,
        [xi.skill.STAFF       ] = 202,
        [xi.skill.POLEARM     ] = 203,
    }

    local animation = animationTable[player:getWeaponSkillType(xi.slot.MAIN)] or 0
    action:setAnimation(target:getID(), animation)

    ability:setMsg(xi.msg.basic.JA_DAMAGE)

    return damage
end)

-- Shikikoyo: Apply merit recast reduction, remove extra TP sharing from merits
m:addOverride('xi.job_utils.samurai.useShikikoyo', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.SHIKIKOYO) - 150
    action:setRecast(action:getRecast() - recastReduction)

    local pTP = player:getTP() - 1000
    pTP       = utils.clamp(pTP, 0, 3000 - target:getTP())

    player:setTP(1000)
    target:setTP(target:getTP() + pTP)

    return pTP
end)

-- Hasso: Remove Zanshin bonus
m:addOverride('xi.effects.hasso.onEffectGain', function(target, effect)
    effect:addMod(xi.mod.TWOHAND_STR, effect:getPower())
    effect:addMod(xi.mod.TWOHAND_HASTE_ABILITY, 1000)
    effect:addMod(xi.mod.TWOHAND_ACC, 10)
end)

-- Seigan: Remove Zanshin-based counter bonus
m:addOverride('xi.effects.seigan.onEffectGain', function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SEIGAN_EFFECT)

    effect:addMod(xi.mod.DEF, jpValue * 3)
end)

return m
