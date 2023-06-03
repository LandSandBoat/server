-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.magicHitRate = xi.combat.magicHitRate or {}
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

-- Actor Magic Accuracy
xi.combat.magicHitRate.calculateActorMagicAccuracy = function(actor, target, spellGroup, skillType, spellElement, statUsed, bonusMacc)
    local actorJob     = actor:getMainJob()
    local actorWeather = actor:getWeather()
    local statDiff     = actor:getStat(statUsed) - target:getStat(statUsed)
    local magicAcc     = actor:getMod(xi.mod.MACC) + actor:getILvlMacc(xi.slot.MAIN)

    -- Get the base magicAcc (just skill + skill mod (79 + skillID = ModID))
    if skillType ~= 0 then
        magicAcc = magicAcc + actor:getSkillLevel(skillType)
    else
        -- For mob skills / additional effects which don't have a skill.
        magicAcc = magicAcc + utils.getSkillLvl(1, actor:getMainLvl())
    end

    -- Add acc for elemental affinity accuracy and element specific accuracy
    if spellElement ~= xi.magic.ele.NONE then
        local elementBonus  = actor:getMod(elementTable[spellElement][1])
        local affinityBonus = actor:getMod(elementTable[spellElement][2]) * 10

        magicAcc            = magicAcc + elementBonus + affinityBonus
    end

    -- Get dStat Magic Accuracy.
    -- dStat is calculated the same for all types of Magic
    -- https://wiki.ffo.jp/html/3500.html
    -- https://wiki.ffo.jp/html/19417.html (Difference in INT validation)
    local dStatMacc = 0

    if statDiff <= -31 then
        dStatMacc = -20 + (statDiff + 30) / 4
    elseif statDiff <= -11 then
        dStatMacc = -10 + (statDiff + 10) / 2
    elseif statDiff < 11 then -- Between -11 and 11
        dStatMacc = statDiff
    elseif statDiff >= 31 then
        dStatMacc = 20 + (statDiff - 30) / 4
    elseif statDiff >= 11 then
        dStatMacc = 10 + (statDiff - 10) / 2
    end

    magicAcc = magicAcc + utils.clamp(dStatMacc, -30, 30)

    -----------------------------------
    -- magicAcc from status effects.
    -----------------------------------
    -- Altruism
    if
        actor:hasStatusEffect(xi.effect.ALTRUISM) and
        spellGroup == xi.magic.spellGroup.WHITE
    then
        magicAcc = magicAcc + actor:getStatusEffect(xi.effect.ALTRUISM):getPower()
    end

    -- Focalization
    if
        actor:hasStatusEffect(xi.effect.FOCALIZATION) and
        spellGroup == xi.magic.spellGroup.BLACK
    then
        magicAcc = magicAcc + actor:getStatusEffect(xi.effect.FOCALIZATION):getPower()
    end

    --Add acc for klimaform
    if
        actor:hasStatusEffect(xi.effect.KLIMAFORM) and
        spellElement > 0 and
        (actorWeather == xi.magic.singleWeatherStrong[spellElement] or actorWeather == xi.magic.doubleWeatherStrong[spellElement])
    then
        magicAcc = magicAcc + 15
    end

    -- Apply Divine Emblem to Banish and Holy families
    if
        actor:hasStatusEffect(xi.effect.DIVINE_EMBLEM) and
        actorJob == xi.job.PLD and
        skillType == xi.skill.DIVINE_MAGIC
    then
        magicAcc = magicAcc + 100 -- TODO: Confirm this value in retail
    end

    -- Elemental seal
    if
        actor:hasStatusEffect(xi.effect.ELEMENTAL_SEAL) and
        not skillType == xi.skill.DARK_MAGIC and
        not skillType == xi.skill.DIVINE_MAGIC and
        spellElement > 0
    then
        magicAcc = magicAcc + 256
    end

    -- Dark Seal
    if
        actor:hasStatusEffect(xi.effect.DARK_SEAL) and
        skillType == xi.skill.DARK_MAGIC
    then
        magicAcc = magicAcc + 256
    end

    -----------------------------------
    -- magicAcc from Job Points.
    -----------------------------------
    switch (actorJob) : caseof
    {
        [xi.job.WHM] = function()
            magicAcc = magicAcc + actor:getJobPointLevel(xi.jp.WHM_MAGIC_ACC_BONUS)
        end,

        [xi.job.BLM] = function()
            magicAcc = magicAcc + actor:getJobPointLevel(xi.jp.BLM_MAGIC_ACC_BONUS)
        end,

        [xi.job.RDM] = function()
            -- RDM Job Point: During saboteur, Enfeebling MACC +2
            if
                skillType == xi.skill.ENFEEBLING_MAGIC and
                actor:hasStatusEffect(xi.effect.SABOTEUR)
            then
                magicAcc = magicAcc + (actor:getJobPointLevel(xi.jp.SABOTEUR_EFFECT)) * 2
            end

            -- RDM Job Point: Magic Accuracy Bonus, All MACC + 1
            magicAcc = magicAcc + actor:getJobPointLevel(xi.jp.RDM_MAGIC_ACC_BONUS)
        end,

        [xi.job.NIN] = function()
            if skillType == xi.skill.NINJUTSU then
                magicAcc = magicAcc + actor:getJobPointLevel(xi.jp.NINJITSU_ACC_BONUS)
            end
        end,

        [xi.job.SCH] = function()
            if
                (spellGroup == xi.magic.spellGroup.WHITE and actor:hasStatusEffect(xi.effect.PARSIMONY)) or
                (spellGroup == xi.magic.spellGroup.BLACK and actor:hasStatusEffect(xi.effect.PENURY))
            then
                magicAcc = magicAcc + actor:getJobPointLevel(xi.jp.STRATEGEM_EFFECT_I)
            end
        end,
    }

    -----------------------------------
    -- magicAcc from Merits.
    -----------------------------------
    switch (actorJob) : caseof
    {
        [xi.job.BLM] = function()
            if skillType == xi.skill.ELEMENTAL_MAGIC then
                magicAcc = magicAcc + actor:getMerit(xi.merit.ELEMENTAL_MAGIC_ACCURACY)
            end
        end,

        [xi.job.RDM] = function()
            -- Category 1
            if
                spellElement >= xi.magic.element.FIRE and
                spellElement <= xi.magic.element.WATER
            then
                magicAcc = magicAcc + actor:getMerit(elementTable[spellElement][5])
            end

            -- Category 2
            magicAcc = magicAcc + actor:getMerit(xi.merit.MAGIC_ACCURACY)
        end,

        [xi.job.NIN] = function()
            if skillType == xi.skill.NINJUTSU then
                magicAcc = magicAcc + actor:getMerit(xi.merit.NIN_MAGIC_ACCURACY)
            end
        end,

        [xi.job.BLU] = function()
            if skillType == xi.skill.BLUE_MAGIC then
                magicAcc = magicAcc + actor:getMerit(xi.merit.MAGICAL_ACCURACY)
            end
        end,
    }

    -----------------------------------
    -- magicAcc from Food.
    -----------------------------------
    local maccFood = magicAcc * (actor:getMod(xi.mod.FOOD_MACCP) / 100)
    magicAcc = magicAcc + utils.clamp(maccFood, 0, actor:getMod(xi.mod.FOOD_MACC_CAP))

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
xi.combat.magicHitRate.calculateTargetMagicEvasion = function(actor, target, spellElement, isEnfeeble, mEvaMod)
    local magicEva   = target:getMod(xi.mod.MEVA) -- Base MACC.
    local resistRank = 0 -- Elemental specific Resistance rank. Acts as multiplier to base MACC.
    local resMod     = 0 -- Elemental specific magic evasion. Acts as a additive bonus to base MACC after affected by resistance rank.
    local levelDiff  = target:getMainLvl() - actor:getMainLvl()

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
xi.combat.magicHitRate.calculateMagicHitRate = function(magicAcc, magicEva)
    local magicAccDiff = magicAcc - magicEva

    if magicAccDiff < 0 then
        magicAccDiff = math.floor(magicAccDiff / 2)
    end

    local magicHitRate = utils.clamp(50 + magicAccDiff, 5, 95)

    return magicHitRate
end

xi.combat.magicHitRate.calculateResistRate = function(actor, target, skillType, spellElement, magicHitRate)
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
            not actor:hasStatusEffect(xi.effect.SUBTLE_SORCERY)
        then
            resistRate = resistRate / 2
        end
    end

    return resistRate
end
