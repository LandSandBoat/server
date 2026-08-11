-----------------------------------
-- Module: Paladin Job Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_job_utils_paladin')

-- Rampart: Revert to a magical damage stoneskin effect for party members
-- TODO: find a patch note or source for this change
m:addOverrideByEra('xi.job_utils.paladin.useRampart', {
    [xi.expansion.ROV] = function(player, target, ability)
        local duration    = 30 + player:getMod(xi.mod.RAMPART_DURATION)
        local stoneskinHP = player:getStat(xi.mod.VIT) * 2
        local defense     = player:getMainLvl() == 75 and 23 or 21

        -- Apply STONESKIN effect but display as RAMPART icon
        target:addStatusEffect(xi.effect.STONESKIN, { power = defense, duration = duration, origin   = player, icon = xi.effect.RAMPART, subType  = 2, subPower = stoneskinHP })

        return xi.effect.RAMPART
    end,
})

-- Stoneskin onEffectGain: Add defense buff when displayed as RAMPART
m:addOverrideByEra('xi.effects.stoneskin.onEffectGain', {
    [xi.expansion.ROV] = function(target, effect)
        if effect:getIcon() == xi.effect.RAMPART then
            effect:addMod(xi.mod.DEF, effect:getPower())
        end
    end,
})

-- Holy Circle: Revert duration from 3 minutes to 1 minute
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
m:addOverrideByEra('xi.job_utils.paladin.useHolyCircle', {
    [xi.expansion.ABYSSEA] = function(player, target, ability)
        local duration = 60 + player:getMod(xi.mod.HOLY_CIRCLE_DURATION)
        local power    = 15

        if player:getMainJob() ~= xi.job.PLD then
            power = 5
        end

        power = power + player:getMod(xi.mod.HOLY_CIRCLE_POTENCY)

        target:addStatusEffect(xi.effect.HOLY_CIRCLE, { power = power, duration = duration, origin = player })

        return xi.effect.HOLY_CIRCLE
    end,
})

-- Chivalry: Remove increased MP bonus from merits and reduces cooldown per merit
-- TODO: find a patch note or source for this change
m:addOverrideByEra('xi.job_utils.paladin.useChivalry', {
    [xi.expansion.ABYSSEA] = function(player, target, ability, action)
        local recastReduction = player:getMerit(xi.merit.CHIVALRY) - 150
        action:setRecast(action:getRecast() - recastReduction)

        local tp     = target:getTP()
        local base   = 0.05 + (player:getMod(xi.mod.ENHANCES_CHIVALRY) / 100)
        -- MP gained = (TP * 0.05) + (0.0015 * TP * MND)
        local amount = (tp * base) + (0.0015 * tp * target:getStat(xi.mod.MND))

        target:setTP(0)

        return target:addMP(amount)
    end,
})

-- Fealty: Remove duration increase per merit and reduces cooldown per merit
-- TODO: find a patch note or source for this change
m:addOverrideByEra('xi.job_utils.paladin.useFealty', {
    [xi.expansion.ABYSSEA] = function(player, target, ability, action)
        local recastReduction = player:getMerit(xi.merit.FEALTY) - 150
        action:setRecast(action:getRecast() - recastReduction)

        -- Divide by merit value (150s in pre-Abyssea) to recover merit rank count for gear scaling
        local enhFealty = (player:getMerit(xi.merit.FEALTY) / 150) * player:getMod(xi.mod.ENHANCES_FEALTY)
        local duration  = 60 + enhFealty

        player:addStatusEffect(xi.effect.FEALTY, { power = 1, duration = duration, origin = player })

        return xi.effect.FEALTY
    end,
})

-- Shield Bash: Remove shield size damage bonuses and job point additions
-- TODO: find a patch note or source for this change
m:addOverrideByEra('xi.job_utils.paladin.useShieldBash', {
    [xi.expansion.ABYSSEA] = function(player, target, ability)
        local damage = math.floor(player:getMainLvl() * 0.28)

        -- Main job factors
        if player:getMainJob() ~= xi.job.PLD then
            damage = math.floor(damage / 2.5)
        else
            damage = math.floor(damage)
        end

        damage = damage + player:getMod(xi.mod.SHIELD_BASH)

        -- Apply stun effect
        if
            not xi.data.statusEffect.isTargetImmune(target, xi.effect.STUN, xi.element.THUNDER) and
            not xi.data.statusEffect.isTargetResistant(player, target, xi.effect.STUN) and
            not xi.data.statusEffect.isEffectNullified(target, xi.effect.STUN, 0)
        then
            local maccParams =
            {
                effectId       = xi.effect.STUN,
                magicalElement = xi.element.THUNDER,
                skillRank      = xi.skillRank.A_PLUS,
                actorStat      = xi.mod.INT,
            }

            local resistanceRate = xi.combat.magicHitRate.calculateResistRate(player, target, maccParams)
            if xi.data.statusEffect.isResistRateSuccessfull(xi.effect.STUN, resistanceRate, 0) then
                target:addStatusEffect(xi.effect.STUN, { power = 1, duration = math.randomInt(2, 8) * resistanceRate, origin = player })
            end
        end

        -- Randomize damage
        local randomizer = 1 + (math.randomInt(1, 5) / 100)

        damage = damage * randomizer
        damage = utils.handleStoneskin(target, damage)

        target:takeDamage(damage, player, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
        target:updateEnmityFromDamage(player, damage)
        ability:setMsg(xi.msg.basic.JA_DAMAGE)

        return damage
    end,
})
