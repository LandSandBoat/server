-----------------------------------
-- Absorb Spell Utilities
-- Drain, Aspir, Absorb-TP, Absorb-STAT, Absorb-Attri
-----------------------------------
require('scripts/globals/combat/magic_hit_rate')
require('scripts/globals/spells/damage_spell')
-----------------------------------
xi = xi or {}
xi.spells = xi.spells or {}
xi.spells.absorb = xi.spells.absorb or {}
-----------------------------------

local absorbStatData =
{
    [xi.magic.spell.ABSORB_STR] = { boostEffect = xi.effect.STR_BOOST,      downEffect = xi.effect.STR_DOWN,      msg = xi.msg.basic.MAGIC_ABSORB_STR },
    [xi.magic.spell.ABSORB_DEX] = { boostEffect = xi.effect.DEX_BOOST,      downEffect = xi.effect.DEX_DOWN,      msg = xi.msg.basic.MAGIC_ABSORB_DEX },
    [xi.magic.spell.ABSORB_VIT] = { boostEffect = xi.effect.VIT_BOOST,      downEffect = xi.effect.VIT_DOWN,      msg = xi.msg.basic.MAGIC_ABSORB_VIT },
    [xi.magic.spell.ABSORB_AGI] = { boostEffect = xi.effect.AGI_BOOST,      downEffect = xi.effect.AGI_DOWN,      msg = xi.msg.basic.MAGIC_ABSORB_AGI },
    [xi.magic.spell.ABSORB_INT] = { boostEffect = xi.effect.INT_BOOST,      downEffect = xi.effect.INT_DOWN,      msg = xi.msg.basic.MAGIC_ABSORB_INT },
    [xi.magic.spell.ABSORB_MND] = { boostEffect = xi.effect.MND_BOOST,      downEffect = xi.effect.MND_DOWN,      msg = xi.msg.basic.MAGIC_ABSORB_MND },
    [xi.magic.spell.ABSORB_CHR] = { boostEffect = xi.effect.CHR_BOOST,      downEffect = xi.effect.CHR_DOWN,      msg = xi.msg.basic.MAGIC_ABSORB_CHR },
    [xi.magic.spell.ABSORB_ACC] = { boostEffect = xi.effect.ACCURACY_BOOST, downEffect = xi.effect.ACCURACY_DOWN, msg = xi.msg.basic.MAGIC_ABSORB_ACC },
}

-- https://www.bg-wiki.com/ffxi/Category:Absorb_Spell
xi.spells.absorb.doAbsorbStatSpell = function(caster, target, spell)
    local spellId          = spell:getID()
    local enhancingEffect  = absorbStatData[spellId].boostEffect
    local enfeeblingEffect = absorbStatData[spellId].downEffect

    -- Calculate resistance (2 state effects: Either No resist, half resist or full resist)
    local resist = xi.combat.magicHitRate.calculateResistRate(caster, target, xi.magic.spellGroup.BLACK, xi.skill.DARK_MAGIC, 0, xi.element.DARK, xi.mod.INT, enfeeblingEffect, 0)
    if resist < 0.5 then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        return 0
    end

    -- Calculate potency.
    local basePotency          = 3 + math.floor(caster:getMainLvl() / 5)
    local gearMultiplier       = 1 + caster:getMod(xi.mod.AUGMENTS_ABSORB) / 100
    local liberatorMultiplier  = 1 + caster:getMod(xi.mod.AUGMENTS_ABSORB_LIBERATOR) / 100
    local netherVoidMultiplier = 1
    if caster:hasStatusEffect(xi.effect.NETHER_VOID) then
        netherVoidMultiplier = 1 + caster:getStatusEffect(xi.effect.NETHER_VOID):getPower() / 100
    end

    local finalPotency = math.floor(basePotency * gearMultiplier * liberatorMultiplier)
    finalPotency       = math.floor(finalPotency * netherVoidMultiplier)

    -- Calculate duration.
    -- NOTE: Wiki information is contradicting.
    -- It states duration from gear (Absorb effect duration) is additive in gear pages and in table, but multiplicative in the equation.
    local baseDuration           = utils.clamp(180 + math.floor((caster:getSkillLevel(xi.skill.DARK_MAGIC) - 490.5) / 5), 0, 10000)
    local darkDurationMultiplier = 1 + caster:getMod(xi.mod.DARK_MAGIC_DURATION) / 100
    local durationGearMultiplier = 1 + caster:getMod(xi.mod.ABSORB_EFFECT_DURATION) / 100

    local finalDuration = math.floor(baseDuration * darkDurationMultiplier * durationGearMultiplier) + caster:getMod(xi.mod.ENHANCES_ABSORB_EFFECTS) -- Assume additive. TODO: Testing needed.

    -- Apply debuff and buff if needed. Absorb effects can be overwriten via higher potency.
    if target:addStatusEffect(enfeeblingEffect, finalPotency, 0, finalDuration) then
        -- Set associated message.
        spell:setMsg(absorbStatData[spellId].msg)

        -- Force-overwrite associated buff.
        caster:delStatusEffect(enhancingEffect)
        caster:addStatusEffect(enhancingEffect, finalPotency, 0, finalDuration)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return enfeeblingEffect
end

local absorbPointsData =
{
    -- [spell ID] = { parameter, { skill <= 300 }, { skill > 300 }, divisor, increase max HP? }
    [xi.magic.spell.DRAIN    ] = { xi.mod.HP, {   1,  20 }, { 0.625, 132.5 }, 0.50, false },
    [xi.magic.spell.DRAIN_II ] = { xi.mod.HP, {   1, 165 }, {     1,   165 }, 0.66, true  },
    [xi.magic.spell.DRAIN_III] = { xi.mod.HP, {   1, 255 }, {   1.5,   105 }, 0.75, true  },
    [xi.magic.spell.ASPIR    ] = { xi.mod.MP, { 0.3,  20 }, {   0.4,     0 }, 0.50, false },
    [xi.magic.spell.ASPIR_II ] = { xi.mod.MP, { 0.5,  30 }, {   0.6,     0 }, 0.50, false },
    [xi.magic.spell.ASPIR_III] = { xi.mod.MP, { 0.7,  40 }, {   0.8,     0 }, 0.50, false },
}

-- https://www.bg-wiki.com/ffxi/Category:Drain/Aspir_Spell
-- https://wiki-ffo-jp.translate.goog/html/923.html?_x_tr_sl=ja&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=sc
xi.spells.absorb.doDrainingSpell = function(caster, target, spell)
    local finalDamage  = 0
    local spellId      = spell:getID()
    local modAbsorbed  = absorbPointsData[spellId][1]
    local targetPoints = target:getHP()
    local displayCap   = caster:getMaxHP() - caster:getHP()

    if modAbsorbed == xi.mod.MP then
        targetPoints = target:getMP()
        displayCap   = caster:getMaxMP() - caster:getMP()
    end

    -- Early return: Target is undead.
    if target:isUndead() then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return finalDamage
    end

    -- Early return: Target absorbs or nullifies dark.
    if
        xi.spells.damage.calculateAbsorption(target, xi.element.DARK, true) ~= 1 or
        xi.spells.damage.calculateNullification(target, xi.element.DARK, true, false) ~= 1
    then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        return finalDamage
    end

    -- Early return: Target doesn't have HP/MP to absorb.
    if targetPoints == 0 then
        spell:setMsg(xi.msg.basic.NO_EFFECT)
        return finalDamage
    end

    -- Base damage.
    local casterSkill        = caster:getSkillLevel(xi.skill.DARK_MAGIC)
    local skillEquation      = casterSkill > 300 and 3 or 2
    local maxDamagePotential = math.floor(casterSkill * absorbPointsData[spellId][skillEquation][1] + absorbPointsData[spellId][skillEquation][2])
    local minDamagePotential = math.floor(maxDamagePotential * absorbPointsData[spellId][4])
    local baseDamage         = math.random(minDamagePotential, maxDamagePotential)

    -- Multipliers.
    local resistTier             = xi.combat.magicHitRate.calculateResistRate(caster, target, xi.magic.spellGroup.BLACK, xi.skill.DARK_MAGIC, 0, xi.element.DARK, xi.mod.INT, 0, 0)
    local additionalResistTier   = xi.spells.damage.calculateAdditionalResistTier(caster, target, xi.element.DARK)
    local sdt                    = xi.spells.damage.calculateSDT(target, xi.element.DARK)
    local elementalStaffBonus    = xi.spells.damage.calculateElementalStaffBonus(caster, xi.element.DARK)
    local elementalAffinityBonus = xi.spells.damage.calculateElementalAffinityBonus(caster, xi.element.DARK)
    local dayAndWeather          = xi.spells.damage.calculateDayAndWeather(caster, xi.element.DARK, false)
    local absorbMultiplier       = 1 + caster:getMod(xi.mod.AUGMENTS_ABSORB) / 100
    local liberatorMultiplier    = 1 + caster:getMod(xi.mod.AUGMENTS_ABSORB_LIBERATOR) / 100
    local netherVoidMultiplier   = 1
    if caster:hasStatusEffect(xi.effect.NETHER_VOID) then
        netherVoidMultiplier = 1 + caster:getStatusEffect(xi.effect.NETHER_VOID):getPower() / 100
    end

    -- Operations.
    finalDamage = math.floor(baseDamage * resistTier)
    finalDamage = math.floor(finalDamage * additionalResistTier)
    finalDamage = math.floor(finalDamage * sdt)
    finalDamage = math.floor(finalDamage * elementalStaffBonus)
    finalDamage = math.floor(finalDamage * elementalAffinityBonus)
    finalDamage = math.floor(finalDamage * dayAndWeather)
    finalDamage = math.floor(finalDamage * absorbMultiplier)
    finalDamage = math.floor(finalDamage * liberatorMultiplier)
    finalDamage = math.floor(finalDamage * netherVoidMultiplier)

    -- Final operations.
    if modAbsorbed == xi.mod.HP then
        finalDamage = utils.clamp(finalDamage - target:getMod(xi.mod.PHALANX), 0, 99999)
        finalDamage = utils.clamp(utils.oneforall(target, finalDamage), 0, 99999)
        finalDamage = utils.clamp(utils.stoneskin(target, finalDamage), -99999, 99999)
        finalDamage = utils.clamp(finalDamage, 0, targetPoints)
        finalDamage = target:checkDamageCap(finalDamage)

        -- Handle Bind break and TP?
        target:takeSpellDamage(caster, spell, finalDamage, xi.attackType.MAGICAL, xi.damageType.DARK)

        -- Handle Afflatus Misery.
        target:handleAfflatusMiseryDamage(finalDamage)

        -- Handle Enmity.
        target:updateEnmityFromDamage(caster, finalDamage)
    else
        finalDamage = utils.clamp(finalDamage, 0, targetPoints)
    end

    -- Drain II and Drain III increase max HP via effect.
    if absorbPointsData[spellId][5] then
        -- Remove cap on damage displayed in log.
        displayCap = 9999 - caster:getHP()

        -- Calculate overflow.
        local overflow = finalDamage + caster:getHP() - caster:getMaxHP()
        if overflow > 0 then
            -- Check if effect should be applied. Only 1 "Max HP Effect" can be in place at a time.
            -- Retail testing suggest that %power effect takes precedent over flat power.
            local hasMaxHPEffect      = caster:hasStatusEffect(xi.effect.MAX_HP_BOOST)
            local maxHPEffectPower    = 0
            local maxHPEffectSubpower = 0

            if hasMaxHPEffect then
                maxHPEffectPower    = caster:getStatusEffect(xi.effect.MAX_HP_BOOST):getPower()
                maxHPEffectSubpower = caster:getStatusEffect(xi.effect.MAX_HP_BOOST):getSubPower()
            end

            if
                not hasMaxHPEffect or           -- No effect present, so apply.
                (maxHPEffectPower == 0 and      -- Effect present, but it isn't %. If subpower is higher, we can override the effect.
                maxHPEffectSubpower < overflow) -- Subpower present is lower than new one, so we can override the effect.
            then
                local duration = 180 + 180 * caster:getMod(xi.mod.DARK_MAGIC_DURATION) / 100
                caster:delStatusEffect(xi.effect.MAX_HP_BOOST)
                caster:addStatusEffect(xi.effect.MAX_HP_BOOST, 0, 0, duration, 0, overflow)
            end
        end
    end

    -- Perform (non) damage and healing.
    if modAbsorbed == xi.mod.HP then
        caster:addHP(finalDamage)
    else
        caster:addMP(finalDamage)
        target:delMP(finalDamage)
    end

    -- Displayed damage in log is the amount the player heals by, not the damage actually done.
    local displayDamage = utils.clamp(finalDamage, 0, displayCap)

    return displayDamage
end

xi.spells.absorb.doAbsorbTPSpell = function(caster, target, spell)
    local finalDamage = 0

    -- Early return: Target absorbs or nullifies dark.
    if
        xi.spells.damage.calculateAbsorption(target, xi.element.DARK, true) ~= 1 or
        xi.spells.damage.calculateNullification(target, xi.element.DARK, true, false) ~= 1
    then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        return finalDamage
    end

    -- Early return: Target doesn't have TP to absorb.
    local targetTP = target:getTP()
    if targetTP == 0 then
        spell:setMsg(xi.msg.basic.NO_EFFECT)
        return finalDamage
    end

    -- Base damage.
    local baseDamage = targetTP * 30 / 100

    -- Multipliers.
    local resistTier           = xi.combat.magicHitRate.calculateResistRate(caster, target, xi.magic.spellGroup.BLACK, xi.skill.DARK_MAGIC, 0, xi.element.DARK, xi.mod.INT, 0, 0)
    local additionalResistTier = xi.spells.damage.calculateAdditionalResistTier(caster, target, xi.element.DARK)
    local sdt                  = xi.spells.damage.calculateSDT(target, xi.element.DARK)
    local elementalStaffBonus  = xi.spells.damage.calculateElementalStaffBonus(caster, xi.element.DARK)
    local dayAndWeather        = xi.spells.damage.calculateDayAndWeather(caster, xi.element.DARK, false)
    local absorbMultiplier     = 1 + caster:getMod(xi.mod.AUGMENTS_ABSORB) / 100
    local absorbTpMultiplier   = 1 + caster:getMod(xi.mod.AUGMENTS_ABSORB_TP) / 100 -- TODO: Additive with aug abs or multiplicative?
    local liberatorMultiplier  = 1 + caster:getMod(xi.mod.AUGMENTS_ABSORB_LIBERATOR) / 100

    -- Operations.
    finalDamage = math.floor(baseDamage * resistTier)
    finalDamage = math.floor(finalDamage * additionalResistTier)
    finalDamage = math.floor(finalDamage * sdt)
    finalDamage = math.floor(finalDamage * elementalStaffBonus)
    finalDamage = math.floor(finalDamage * dayAndWeather)
    finalDamage = math.floor(finalDamage * absorbMultiplier)
    finalDamage = math.floor(finalDamage * absorbTpMultiplier)
    finalDamage = math.floor(finalDamage * liberatorMultiplier)

    -- Clamp
    finalDamage = utils.clamp(finalDamage, 0, 3000)

    -- Set proper message.
    spell:setMsg(xi.msg.basic.MAGIC_ABSORB_TP)

    -- Perform drain.
    caster:addTP(finalDamage)
    target:addTP(-finalDamage)

    return finalDamage
end

xi.spells.absorb.doAbsorbAttriSpell = function(caster, target, spell)
    local count       = 0
    local effectFirst = caster:stealStatusEffect(target, xi.effectFlag.DISPELABLE)

    if effectFirst ~= 0 then
        count = 1

        if caster:hasStatusEffect(xi.effect.NETHER_VOID) then
            local effectSecond = caster:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
            if effectSecond ~= 0 then
                count = count + 1
            end
        end

        spell:setMsg(xi.msg.basic.MAGIC_STEAL)

        return count
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- No effect
    end

    return count
end
