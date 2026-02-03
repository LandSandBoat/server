-----------------------------------
-- Module: Job Adjustments (Abyssea Era)
-- Desc: Removes traits/abilities/effects that were added to jobs during the Abyssea era
-----------------------------------
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('abyssea_job_adjustments')

-----------------------------------
-- Warrior
-----------------------------------

-- Warrior's Charge: Remove Triple Attack bonus
m:addOverride('xi.effects.warriors_charge.onEffectGain', function(target, effect)
    effect:addMod(xi.mod.DOUBLE_ATTACK, 100)
end)

-- Warrior's Charge: Apply merit recast reduction
m:addOverride('xi.job_utils.warrior.useWarriorsCharge', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.WARRIORS_CHARGE) - 150
    action:setRecast(action:getRecast() - recastReduction)

    player:addStatusEffect(xi.effect.WARRIORS_CHARGE, 1, 0, 60)

    return xi.effect.WARRIORS_CHARGE
end)

-----------------------------------
-- White Mage
-----------------------------------

-- Martyr: Apply merit recast reduction, remove merit healing bonus
m:addOverride('xi.job_utils.white_mage.useMartyr', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.MARTYR) - 150
    action:setRecast(action:getRecast() - recastReduction)

    local damageHP = math.floor(player:getHP() * 0.25)
    local healHP = damageHP * 2
    healHP = utils.clamp(healHP, 0, target:getMaxHP() - target:getHP())

    -- If stoneskin is present, it should absorb damage
    damageHP = utils.handleStoneskin(player, damageHP)
    player:delHP(damageHP)
    target:addHP(healHP)

    return healHP
end)

-- Devotion: Apply merit recast reduction, remove merit MP bonus
m:addOverride('xi.job_utils.white_mage.useDevotion', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.DEVOTION) - 150
    action:setRecast(action:getRecast() - recastReduction)

    local damageHP = math.floor(player:getHP() * 0.25)
    local healMP = damageHP
    healMP = utils.clamp(healMP, 0, target:getMaxMP() - target:getMP())

    -- If stoneskin is present, it should absorb damage
    damageHP = utils.handleStoneskin(player, damageHP)
    player:delHP(damageHP)
    target:addMP(healMP)

    return healMP
end)

-----------------------------------
-- Thief
-----------------------------------

-- Assassin's Charge: Remove Quadruple Attack
m:addOverride('xi.effects.assassins_charge.onEffectGain', function(target, effect)
    effect:addMod(xi.mod.TRIPLE_ATTACK, 100)
end)

-- Assassin's Charge: Reduce cooldown by merit count
m:addOverride('xi.job_utils.thief.useAssassinsCharge', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.ASSASSINS_CHARGE) - 150
    action:setRecast(action:getRecast() - recastReduction)

    player:addStatusEffect(xi.effect.ASSASSINS_CHARGE, 1, 0, 60)

    return xi.effect.ASSASSINS_CHARGE
end)

-- Feint: Remove Treasure Hunter rate and reduce cooldown by merit count
m:addOverride('xi.job_utils.thief.useFeint', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.FEINT) - 120
    action:setRecast(action:getRecast() - recastReduction)

    player:addStatusEffect(xi.effect.FEINT, 150, 0, 60)
end)

-----------------------------------
-- Dark Knight
-----------------------------------

-- Arcane Circle: Revert duration from 3 minutes to 1 minute
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
m:addOverride('xi.job_utils.dark_knight.useArcaneCircle', function(player, target, ability)
    local duration = 60 + player:getMod(xi.mod.ARCANE_CIRCLE_DURATION)
    local power    = 15

    if player:getMainJob() ~= xi.job.DRK then
        power = 5
    end

    power = power + player:getMod(xi.mod.ARCANE_CIRCLE_POTENCY)

    -- Handle simplified message for other party members.
    if player:getID() ~= target:getID() then
        ability:setMsg(xi.msg.basic.FORTIFIED_ARCANA)
    end

    target:addStatusEffect(xi.effect.ARCANE_CIRCLE, power, 0, duration)

    return xi.effect.ARCANE_CIRCLE
end)

-- Last Resort: Revert duration from 3 minutes to 30 seconds
m:addOverride('xi.job_utils.dark_knight.useLastResort', function(player, target, ability)
    player:addStatusEffect(xi.effect.LAST_RESORT, 0, 0, 30)

    return xi.effect.LAST_RESORT
end)

-- Dark Seal: Remove extra duration and cast speed from merits
m:addOverride('xi.effects.warriors_charge.onEffectGain',  function(target, effect)
    -- Overwrites
    target:delStatusEffectSilent(xi.effect.DIVINE_EMBLEM)
    target:delStatusEffectSilent(xi.effect.DIVINE_SEAL)
    target:delStatusEffectSilent(xi.effect.ELEMENTAL_SEAL)
end)

-- Dark Seal: Apply merit recast reduction
m:addOverride('xi.job_utils.dark_knight.useDarkSeal', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.DARK_SEAL) - 150
    action:setRecast(action:getRecast() - recastReduction)

    player:addStatusEffect(xi.effect.DARK_SEAL, 1, 0, 60)

    return xi.effect.DARK_SEAL
end)

-- Diabolic Eye: Remove extra duration and potency from merits and apply merit recast reduction
m:addOverride('xi.job_utils.dark_knight.useDiabolicEye', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.DIABOLIC_EYE) - 150
    action:setRecast(action:getRecast() - recastReduction)

    player:addStatusEffect(xi.effect.DIABOLIC_EYE, 20, 0, 180)

    return xi.effect.DIABOLIC_EYE
end)

-----------------------------------
-- Beastmaster
-----------------------------------

-- Reward: Override pet food healing values to pre-Abyssea values
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(09/08/2010)
xi.job_utils.beastmaster.petFoodData =
{
    [xi.item.PET_FOOD_ALPHA_BISCUIT]   = { minHealing =  25, regen =  1, mndMult = 2, mndThreshold = 10 },
    [xi.item.PET_FOOD_BETA_BISCUIT]    = { minHealing =  50, regen =  3, mndMult = 1, mndThreshold = 33 },
    [xi.item.PET_FOOD_GAMMA_BISCUIT]   = { minHealing = 100, regen =  5, mndMult = 1, mndThreshold = 35 },
    [xi.item.PET_FOOD_DELTA_BISCUIT]   = { minHealing = 150, regen =  8, mndMult = 2, mndThreshold = 40 },
    [xi.item.PET_FOOD_EPSILON_BISCUIT] = { minHealing = 300, regen = 11, mndMult = 2, mndThreshold = 45 },
    [xi.item.PET_FOOD_ZETA_BISCUIT]    = { minHealing = 350, regen = 14, mndMult = 3, mndThreshold = 45 },
}

-- Feral Howl: Apply merit recast reduction, remove extra accuracy from merits
m:addOverride('xi.job_utils.beastmaster.useFeralHowl', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.FERAL_HOWL) - 150
    action:setRecast(action:getRecast() - recastReduction)

    if
        not xi.data.statusEffect.isTargetImmune(target, xi.effect.TERROR, xi.element.DARK) and
        not xi.data.statusEffect.isTargetResistant(player, target, xi.effect.TERROR) and
        not xi.data.statusEffect.isEffectNullified(target, xi.effect.TERROR, 0)
    then
        local resistanceRate = xi.combat.magicHitRate.calculateResistRate(player, target, 0, 0, xi.skillRank.B_MINUS, xi.element.DARK, xi.mod.CHR, xi.effect.TERROR)

        if xi.data.statusEffect.isResistRateSuccessfull(xi.effect.TERROR, resistanceRate, 0) then
            target:addStatusEffect(xi.effect.TERROR, 1, 0, 10 * resistanceRate)
        end
    end

    return xi.effect.TERROR
end)

-- Killer Insinct: Apply merit recast reduction, remove extra duration from merits
m:addOverride('xi.job_utils.beastmaster.useKillerInstinct', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.KILLER_INSTINCT) - 150
    action:setRecast(action:getRecast() - recastReduction)

    -- Notes: Pet ecosystem is assigned to the subPower, then mapped to the correct killer mod in the effect script.
    local pet          = player:getPet()
    local petEcosystem = pet:getEcosystem()
    local power        = 10

    target:addStatusEffect(xi.effect.KILLER_INSTINCT, power, 0, 60, 0, petEcosystem)

    return xi.effect.KILLER_INSTINCT
end)

return m
