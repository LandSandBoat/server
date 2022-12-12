-----------------------------------
xi = xi or {}
xi.damage = xi.damage or {}
xi.damage.magicHitRate = xi.damage.magicHitRate or {}
-----------------------------------

-- Modifier table per element.
local elementTable =
{
    [xi.magic.element.FIRE   ] = { xi.mod.FIREACC,    xi.mod.FIRE_AFFINITY_ACC,    xi.mod.FIRE_MEVA,    xi.mod.FIRE_RES_RANK,    xi.merit.FIRE_MAGIC_ACCURACY      },
    [xi.magic.element.ICE    ] = { xi.mod.ICEACC,     xi.mod.ICE_AFFINITY_ACC,     xi.mod.ICE_MEVA,     xi.mod.ICE_RES_RANK,     xi.merit.ICE_MAGIC_ACCURACY       },
    [xi.magic.element.WIND   ] = { xi.mod.WINDACC,    xi.mod.WIND_AFFINITY_ACC,    xi.mod.WIND_MEVA,    xi.mod.WIND_RES_RANK,    xi.merit.WIND_MAGIC_ACCURACY      },
    [xi.magic.element.EARTH  ] = { xi.mod.EARTHACC,   xi.mod.EARTH_AFFINITY_ACC,   xi.mod.EARTH_MEVA,   xi.mod.EARTH_RES_RANK,   xi.merit.EARTH_MAGIC_ACCURACY     },
    [xi.magic.element.THUNDER] = { xi.mod.THUNDERACC, xi.mod.THUNDER_AFFINITY_ACC, xi.mod.THUNDER_MEVA, xi.mod.THUNDER_RES_RANK, xi.merit.LIGHTNING_MAGIC_ACCURACY },
    [xi.magic.element.WATER  ] = { xi.mod.WATERACC,   xi.mod.WATER_AFFINITY_ACC,   xi.mod.WATER_MEVA,   xi.mod.WATER_RES_RANK,   xi.merit.WATER_MAGIC_ACCURACY     },
    [xi.magic.element.LIGHT  ] = { xi.mod.LIGHTACC,   xi.mod.LIGHT_AFFINITY_ACC,   xi.mod.LIGHT_MEVA,   xi.mod.LIGHT_RES_RANK,   0                                 },
    [xi.magic.element.DARK   ] = { xi.mod.DARKACC,    xi.mod.DARK_AFFINITY_ACC,    xi.mod.DARK_MEVA,    xi.mod.DARK_RES_RANK,    0                                 },
}

-- Caster Magic Accuracy
xi.damage.magicHitRate.calculateCasterMagicAccuracy = function(caster, target, spell, skillType, spellElement, statUsed)
    local casterJob     = caster:getMainJob()
    local casterWeather = caster:getWeather()
    local spellGroup    = spell and spell:getSpellGroup() or xi.magic.spellGroup.NONE
    local statDiff      = caster:getStat(statUsed) - target:getStat(statUsed)

    local magicAcc      = caster:getMod(xi.mod.MACC) + caster:getILvlMacc()

    -- Get the base magicAcc (just skill + skill mod (79 + skillID = ModID))
    if skillType ~= 0 then
        magicAcc = magicAcc + caster:getSkillLevel(skillType)
    else
        -- For mob skills / additional effects which don't have a skill.
        magicAcc = magicAcc + utils.getSkillLvl(1, caster:getMainLvl())
    end

    -- Add acc for elemental affinity accuracy and element specific accuracy
    if spellElement ~= xi.magic.ele.NONE then
        local elementBonus  = caster:getMod(elementTable[spellElement][1])
        local affinityBonus = caster:getMod(elementTable[spellElement][2]) * 10

        magicAcc            = magicAcc + elementBonus + affinityBonus
    end

    -- Get dStat Magic Accuracy. NOTE: Ninjutsu does not get this bonus/penalty.
    if skillType ~= xi.skill.NINJUTSU then
        if statDiff >= 70 then
            magicAcc = magicAcc + 30
        elseif statDiff > 30 then
            magicAcc = magicAcc + 20 + math.floor((statDiff - 30) / 4)
        elseif statDiff > 10 then
            magicAcc = magicAcc + 10 + math.floor((statDiff - 10) / 2)
        else
            magicAcc = magicAcc + statDiff
        end
    end

    -----------------------------------
    -- magicAcc from status effects.
    -----------------------------------
    -- Altruism
    if
        caster:hasStatusEffect(xi.effect.ALTRUISM) and
        spellGroup == xi.magic.spellGroup.WHITE
    then
        magicAcc = magicAcc + caster:getStatusEffect(xi.effect.ALTRUISM):getPower()
    end

    -- Focalization
    if
        caster:hasStatusEffect(xi.effect.FOCALIZATION) and
        spellGroup == xi.magic.spellGroup.BLACK
    then
        magicAcc = magicAcc + caster:getStatusEffect(xi.effect.FOCALIZATION):getPower()
    end

    --Add acc for klimaform
    if
        caster:hasStatusEffect(xi.effect.KLIMAFORM) and
        spellElement > 0 and
        (casterWeather == xi.magic.singleWeatherStrong[spellElement] or casterWeather == xi.magic.doubleWeatherStrong[spellElement])
    then
        magicAcc = magicAcc + 15
    end

    -- Apply Divine Emblem to Banish and Holy families
    if
        caster:hasStatusEffect(xi.effect.DIVINE_EMBLEM) and
        casterJob == xi.job.PLD and
        skillType == xi.skill.DIVINE_MAGIC
    then
        magicAcc = magicAcc + 100 -- TODO: Confirm this value in retail
    end

    -- Elemental seal
    if
        caster:hasStatusEffect(xi.effect.ELEMENTAL_SEAL) and
        not skillType == xi.skill.DARK_MAGIC and
        not skillType == xi.skill.DIVINE_MAGIC and
        spellElement > 0
    then
        magicAcc = magicAcc + 256
    end

    -- Dark Seal
    if
        caster:hasStatusEffect(xi.effect.DARK_SEAL) and
        skillType == xi.skill.DARK_MAGIC
    then
        magicAcc = magicAcc + 256
    end

    -----------------------------------
    -- magicAcc from Job Points.
    -----------------------------------
    switch (casterJob) : caseof
    {
        [xi.job.WHM] = function()
            magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.WHM_MAGIC_ACC_BONUS)
        end,

        [xi.job.BLM] = function()
            magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.BLM_MAGIC_ACC_BONUS)
        end,

        [xi.job.RDM] = function()
            -- RDM Job Point: During saboteur, Enfeebling MACC +2
            if
                skillType == xi.skill.ENFEEBLING_MAGIC and
                caster:hasStatusEffect(xi.effect.SABOTEUR)
            then
                magicAcc = magicAcc + (caster:getJobPointLevel(xi.jp.SABOTEUR_EFFECT)) * 2
            end

            -- RDM Job Point: Magic Accuracy Bonus, All MACC + 1
            magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.RDM_MAGIC_ACC_BONUS)
        end,

        [xi.job.NIN] = function()
            if skillType == xi.skill.NINJUTSU then
                magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.NINJITSU_ACC_BONUS)
            end
        end,

        [xi.job.SCH] = function()
            if
                (spellGroup == xi.magic.spellGroup.WHITE and caster:hasStatusEffect(xi.effect.PARSIMONY)) or
                (spellGroup == xi.magic.spellGroup.BLACK and caster:hasStatusEffect(xi.effect.PENURY))
            then
                magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.STRATEGEM_EFFECT_I)
            end
        end,
    }

    -----------------------------------
    -- magicAcc from Merits.
    -----------------------------------
    switch (casterJob) : caseof
    {
        [xi.job.BLM] = function()
            if skillType == xi.skill.ELEMENTAL_MAGIC then
                magicAcc = magicAcc + caster:getMerit(xi.merit.ELEMENTAL_MAGIC_ACCURACY)
            end
        end,

        [xi.job.RDM] = function()
            -- Category 1
            if
                spellElement >= xi.magic.element.FIRE and
                spellElement <= xi.magic.element.WATER
            then
                magicAcc = magicAcc + caster:getMerit(elementTable[spellElement][5])
            end

            -- Category 2
            magicAcc = magicAcc + caster:getMerit(xi.merit.MAGIC_ACCURACY)
        end,

        [xi.job.NIN] = function()
            if skillType == xi.skill.NINJUTSU then
                magicAcc = magicAcc + caster:getMerit(xi.merit.NIN_MAGIC_ACCURACY)
            end
        end,

        [xi.job.BLU] = function()
            if skillType == xi.skill.BLUE_MAGIC then
                magicAcc = magicAcc + caster:getMerit(xi.merit.MAGICAL_ACCURACY)
            end
        end,
    }

    -----------------------------------
    -- magicAcc from Food.
    -----------------------------------
    local maccFood = magicAcc * (caster:getMod(xi.mod.FOOD_MACCP) / 100)
    magicAcc = magicAcc + utils.clamp(maccFood, 0, caster:getMod(xi.mod.FOOD_MACC_CAP))

    -----------------------------------
    -- magicAcc from Magic Burst
    -----------------------------------
    local _, skillchainCount = FormMagicBurst(spellElement, target)

    if skillchainCount > 0 then
        magicAcc = magicAcc + 100
    end

    return magicAcc
end

-- Target Magic Evasion
xi.damage.magicHitRate.calculateTargetMagicEvasion = function(caster, target, spellElement, isEnfeeble, mEvaMod)
    local magicEva   = target:getMod(xi.mod.MEVA) -- Base MACC.
    local resistRank = 0 -- Elemental specific Resistance rank. Acts as multiplier to base MACC.
    local resMod     = 0 -- Elemental specific magic evasion. Acts as a additive bonus to base MACC after affected by resistance rank.
    local levelDiff  = target:getMainLvl() - caster:getMainLvl()

    -- Elemental magic evasion.
    if spellElement ~= xi.magic.ele.NONE then
        -- Mod set in database for mobs. Base 0 means not resistant nor weak. Bar-element spells included here.
        resMod     = target:getMod(elementTable[spellElement][3])
        resistRank = target:getMod(elementTable[spellElement][4])

        magicEva = magicEva * (1 + (resistRank * 0.075))
        magicEva = magicEva + resMod
    end

    -- Magic evasion against specific status effects.
    if isEnfeeble then
        magicEva = magicEva + target:getMod(mEvaMod) + target:getMod(xi.mod.STATUS_MEVA)
    end

    -- Level correction. Target gets a bonus when higher level. Never a penalty.
    if levelDiff > 0 then
        magicEva = magicEva + levelDiff * 4
    end

    return magicEva
end

-- Magic Hit Rate. The function gets fed the result of both functions above.
xi.damage.magicHitRate.calculateMagicHitRate = function(magicAcc, magicEva)
    local magicAccDiff = magicAcc - magicEva

    if magicAccDiff < 0 then
        magicAccDiff = math.floor(magicAccDiff / 2)
    end

    local magicHitRate = utils.clamp(50 + magicAccDiff, 5, 95)

    return magicHitRate
end

xi.damage.magicHitRate.calculateResistRate = function(caster, target, skillType, spellElement, magicHitRate)
    local resistRate = 0
    local resistRank = 0

    -- Magic Shield exception.
    if target:hasStatusEffect(xi.effect.MAGIC_SHIELD, 0) then
        return resistRate
    end

    -- Fetch resistance rank modifier.
    if spellElement ~= xi.magic.ele.NONE then
        resistRank = target:getMod(elementTable[spellElement][4])
    end

    -- Resistance Ranks "boons".
    if resistRank > 10 then -- Resistance rank 11 is technically the max, but we check for higher JUST IN CASE something altered it.
        -- TODO: Inmunobreak logic probably goes here

        resistRate = 0.0625
        return resistRate
    elseif resistRank == 10 then
        magicHitRate = 5
    end

    -- Determine final resist based on which thresholds have been crossed.
    local resistTier = 0
    local randomVar  = math.random()

    -- NOTE: Elemental magic evasion "Boons".
    -- According to wiki, 1 positive point in the spell element MEVA allows for an additional tier. This would be tier 3, not the resistance rank tier.
    -- However, it also states that a negative value will also prevent full resists, which is redundant. We already wouldnt be eligible for it.

    for tierVar = 3, 1, -1 do
        if randomVar <= (1 - magicHitRate / 100) ^ tierVar then
            resistTier = tierVar
            break
        end
    end

    resistRate = 1 / (2 ^ resistTier)

    -- Apply additional resistance tier. (The so called "Fourth resist tier"). Subtle sorcery bypasses it.
    if resistRank >= 4 then
        if
            skillType ~= xi.skill.ELEMENTAL_MAGIC or
            not caster:hasStatusEffect(xi.effect.SUBTLE_SORCERY)
        then
            resistRate = resistRate / 2
        end
    end

    return resistRate
end
