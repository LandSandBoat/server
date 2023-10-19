-----------------------------------
-- Global file for magic based skills magic hit rate.
-----------------------------------
require('scripts/globals/combat/element_tables')
require('scripts/globals/combat/level_correction')
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.magicHitRate = xi.combat.magicHitRate or {}

-----------------------------------
-- Calculate Actor Magic Accuracy
-----------------------------------

-- Magic Accuracy from spell's skill.
local function magicAccuracyFromSkill(actor, skillType)
    local magicAcc = 0

    if skillType ~= 0 then
        magicAcc = actor:getSkillLevel(skillType)
    else
        -- For mob skills / additional effects which don't have a skill.
        magicAcc = utils.getSkillLvl(1, actor:getMainLvl())
    end

    return magicAcc
end

-- Magic Accuracy from spell's element.
local function magicAccuracyFromElement(actor, spellElement)
    local magicAcc = 0

    if spellElement ~= xi.element.NONE then
        magicAcc = actor:getMod(xi.combat.element.elementalMagicAcc[spellElement]) + actor:getMod(xi.combat.element.strongAffinityAcc[spellElement]) * 10
    end

    return magicAcc
end

-- Magic Accuracy from Stat Difference between caster and target.
local function magicAccuracyFromStatDifference(actor, target, statUsed)
    local magicAcc = 0
    local statDiff = actor:getStat(statUsed) - target:getStat(statUsed)

    if statDiff <= -31 then
        magicAcc = -20 + (statDiff + 30) / 4
    elseif statDiff <= -11 then
        magicAcc = -10 + (statDiff + 10) / 2
    elseif statDiff < 11 then -- Between -11 and 11
        magicAcc = statDiff
    elseif statDiff >= 31 then
        magicAcc = 20 + (statDiff - 30) / 4
    elseif statDiff >= 11 then
        magicAcc = 10 + (statDiff - 10) / 2
    end

    return utils.clamp(magicAcc, -30, 30)
end

-- Magic Accuracy from Status Effects.
local function magicAccuracyFromStatusEffects(actor, spellGroup, skillType, spellElement)
    local magicAcc     = 0
    local actorJob     = actor:getMainJob()
    local actorWeather = actor:getWeather()

    -- Altruism
    if
        actor:hasStatusEffect(xi.effect.ALTRUISM) and
        spellGroup == xi.magic.spellGroup.WHITE
    then
        magicAcc = actor:getStatusEffect(xi.effect.ALTRUISM):getPower()
    end

    -- Focalization
    if
        actor:hasStatusEffect(xi.effect.FOCALIZATION) and
        spellGroup == xi.magic.spellGroup.BLACK
    then
        magicAcc = magicAcc + actor:getStatusEffect(xi.effect.FOCALIZATION):getPower()
    end

    --Klimaform
    if
        actor:hasStatusEffect(xi.effect.KLIMAFORM) and
        spellElement > 0 and
        (actorWeather == xi.combat.element.strongSingleWeather[spellElement] or actorWeather == xi.combat.element.strongDoubleWeather[spellElement])
    then
        magicAcc = magicAcc + 15
    end

    -- Apply Divine Emblem to Banish and Holy families
    if
        actor:hasStatusEffect(xi.effect.DIVINE_EMBLEM) and
        actorJob == xi.job.PLD and
        skillType == xi.skill.DIVINE_MAGIC
    then
        magicAcc = magicAcc + 256
    end

    -- Elemental seal
    if
        actor:hasStatusEffect(xi.effect.ELEMENTAL_SEAL) and
        skillType ~= xi.skill.DARK_MAGIC and
        skillType ~= xi.skill.DIVINE_MAGIC and
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

    return magicAcc
end

-- Magic Accuracy from Merits.
local function magicAccuracyFromMerits(actor, skillType, spellElement)
    local magicAcc = 0
    local actorJob = actor:getMainJob()

    switch (actorJob) : caseof
    {
        [xi.job.BLM] = function()
            if skillType == xi.skill.ELEMENTAL_MAGIC then
                magicAcc = actor:getMerit(xi.merit.ELEMENTAL_MAGIC_ACCURACY)
            end
        end,

        [xi.job.RDM] = function()
            -- Category 1
            if
                spellElement >= xi.element.FIRE and
                spellElement <= xi.element.WATER
            then
                magicAcc = actor:getMerit(xi.combat.element.rdmMerit[spellElement])
            end

            -- Category 2
            magicAcc = magicAcc + actor:getMerit(xi.merit.MAGIC_ACCURACY)
        end,

        [xi.job.NIN] = function()
            if skillType == xi.skill.NINJUTSU then
                magicAcc = actor:getMerit(xi.merit.NIN_MAGIC_ACCURACY)
            end
        end,

        [xi.job.BLU] = function()
            if skillType == xi.skill.BLUE_MAGIC then
                magicAcc = actor:getMerit(xi.merit.MAGICAL_ACCURACY)
            end
        end,
    }

    return magicAcc
end

-- Magic Accuracy from Job Points.
local function magicAccuracyFromJobPoints(actor, spellGroup, skillType)
    local magicAcc = 0
    local actorJob = actor:getMainJob()

    switch (actorJob) : caseof
    {
        [xi.job.WHM] = function()
            magicAcc = actor:getJobPointLevel(xi.jp.WHM_MAGIC_ACC_BONUS)
        end,

        [xi.job.BLM] = function()
            magicAcc = actor:getJobPointLevel(xi.jp.BLM_MAGIC_ACC_BONUS)
        end,

        [xi.job.RDM] = function()
            -- RDM Job Point: During saboteur, Enfeebling MACC +2
            if
                skillType == xi.skill.ENFEEBLING_MAGIC and
                actor:hasStatusEffect(xi.effect.SABOTEUR)
            then
                magicAcc = actor:getJobPointLevel(xi.jp.SABOTEUR_EFFECT) * 2
            end

            -- RDM Job Point: Magic Accuracy Bonus, All MACC + 1
            magicAcc = magicAcc + actor:getJobPointLevel(xi.jp.RDM_MAGIC_ACC_BONUS)
        end,

        [xi.job.NIN] = function()
            if skillType == xi.skill.NINJUTSU then
                magicAcc = actor:getJobPointLevel(xi.jp.NINJITSU_ACC_BONUS)
            end
        end,

        [xi.job.SCH] = function()
            if
                (spellGroup == xi.magic.spellGroup.WHITE and actor:hasStatusEffect(xi.effect.PARSIMONY)) or
                (spellGroup == xi.magic.spellGroup.BLACK and actor:hasStatusEffect(xi.effect.PENURY))
            then
                magicAcc = actor:getJobPointLevel(xi.jp.STRATEGEM_EFFECT_I)
            end
        end,
    }

    return magicAcc
end

-- Magic Accuracy from Magic Burst.
local function magicAccuracyFromMagicBurst(target, spellElement)
    local magicAcc           = 0
    local _, skillchainCount = xi.magicburst.formMagicBurst(spellElement, target)

    if skillchainCount > 0 then
        magicAcc = 100
    end

    return magicAcc
end

-- Magic Accuracy from Day's Element.
local function magicAccuracyFromDayElement(actor, spellElement)
    local magicAcc = 0

    if
        spellElement ~= xi.element.NONE and
        (math.random(1, 100) <= 33 or actor:getMod(xi.combat.element.elementalObi[spellElement]) >= 1)
    then
        local dayElement = VanadielDayElement()

        -- Strong day.
        if dayElement == spellElement then
            magicAcc = magicAcc + 5

        -- Weak day.
        elseif dayElement == xi.combat.element.weakDay[spellElement] then
            magicAcc = magicAcc - 5
        end
    end

    return magicAcc
end

-- Magic Accuracy from Weather's Element.
local function magicAccuracyFromWeatherElement(actor, spellElement)
    local magicAcc = 0

    -- Calculate if weather bonus triggers.
    if
        spellElement ~= xi.element.NONE and
        (math.random(1, 100) <= 33 or actor:getMod(xi.combat.element.elementalObi[spellElement]) >= 1)
    then
        local actorWeather = actor:getWeather()

        -- Strong weathers.
        if actorWeather == xi.combat.element.strongSingleWeather[spellElement] then
            magicAcc = magicAcc + actor:getMod(xi.mod.IRIDESCENCE) * 5 + 5
        elseif actorWeather == xi.combat.element.strongDoubleWeather[spellElement] then
            magicAcc = magicAcc + actor:getMod(xi.mod.IRIDESCENCE) * 5 + 10

        -- Weak weathers.
        elseif actorWeather == xi.combat.element.weakSingleWeather[spellElement] then
            magicAcc = magicAcc - actor:getMod(xi.mod.IRIDESCENCE) * 5 - 5
        elseif actorWeather == xi.combat.element.weakDoubleWeather[spellElement] then
            magicAcc = magicAcc - actor:getMod(xi.mod.IRIDESCENCE) * 5 - 10
        end
    end

    return magicAcc
end

-- Magic Accuracy from Food.
local function magicAccuracyFromFood(actor, magicAccPreFood)
    local magicAcc = 0
    local foodCap  = actor:getMod(xi.mod.FOOD_MACC_CAP)

    magicAcc = magicAccPreFood * (actor:getMod(xi.mod.FOOD_MACCP) / 100)

    if foodCap > 0 then
        magicAcc = utils.clamp(magicAcc, 0, foodCap)
    end

    return magicAcc
end

-- Global function to calculate total magicc accuracy.
xi.combat.magicHitRate.calculateActorMagicAccuracy = function(actor, target, spellGroup, skillType, spellElement, statUsed, bonusMacc)
    local finalMagicAcc = 0

    local magicAccBase      = actor:getMod(xi.mod.MACC) + actor:getILvlMacc(xi.slot.MAIN)
    local magicAccSkill     = magicAccuracyFromSkill(actor, skillType)
    local magicAccElement   = magicAccuracyFromElement(actor, spellElement)
    local magicAccStatDiff  = magicAccuracyFromStatDifference(actor, target, statUsed)
    local magicAccEffects   = magicAccuracyFromStatusEffects(actor, spellGroup, skillType, spellElement)
    local magicAccMerits    = magicAccuracyFromMerits(actor, skillType, spellElement)
    local magicAccJobPoints = magicAccuracyFromJobPoints(actor, spellGroup, skillType)
    local magicAccBurst     = magicAccuracyFromMagicBurst(target, spellElement)
    local magicAccDay       = magicAccuracyFromDayElement(actor, spellElement)
    local magicAccWeather   = magicAccuracyFromWeatherElement(actor, spellElement)

    -- Add up all magic accuracy before calculating food mAcc %
    local magicAccPreFood = magicAccBase + magicAccSkill + magicAccElement + magicAccStatDiff + magicAccEffects + magicAccMerits + magicAccJobPoints + magicAccBurst + magicAccDay + magicAccWeather + bonusMacc
    local magicAccFood    = magicAccuracyFromFood(actor, magicAccPreFood)

    -- Add up food magic accuracy.
    finalMagicAcc = magicAccPreFood + magicAccFood

    return finalMagicAcc
end

-----------------------------------
-- Calculate Target Magic Evasion
-----------------------------------
local resistRankMultiplier =
{
-- [Rank] = Magic Evasion multiplier.
    [-3] = 0.95,
    [-2] = 0.96019,
    [-1] = 0.98,
    [ 0] = 1,
    [ 1] = 1.023,
    [ 2] = 1.049,
    [ 3] = 1.0905,
    [ 4] = 1.126,
    [ 5] = 1.2075,
    [ 6] = 1.3475,
    [ 7] = 1.70065,
    [ 8] = 2.141,
    [ 9] = 2.2,
    [10] = 2.275, -- Impossible to test since 'Magic Hit Rate' is floored to 5% at this point.
    [11] = 2.35,  -- Impossible to test since 'Magic Hit Rate' is floored to 5% at this point.
}

xi.combat.magicHitRate.calculateTargetMagicEvasion = function(actor, target, spellElement, isEnfeeble, mEvaMod, rankModifier)
    local magicEva   = target:getMod(xi.mod.MEVA) -- Base MACC.
    local resistRank = 0 -- Elemental specific Resistance rank. Acts as multiplier to base MACC.
    local resMod     = 0 -- Elemental specific magic evasion. Acts as a additive bonus to base MACC after affected by resistance rank.
    local levelDiff  = target:getMainLvl() - actor:getMainLvl()

    -- Elemental magic evasion.
    if spellElement ~= xi.element.NONE then
        -- Mod set in database for mobs. Base 0 means not resistant nor weak. Bar-element spells included here.
        resMod     = target:getMod(xi.combat.element.elementalMagicEva[spellElement])
        resistRank = utils.clamp(target:getMod(xi.combat.element.resistRankMod[spellElement]), -3, 11)

        if resistRank > 4 then
            resistRank = utils.clamp(resistRank - rankModifier, 4, 11)
        end

        magicEva = math.floor(magicEva * resistRankMultiplier[resistRank]) + resMod
    end

    -- Magic evasion against specific status effects.
    if isEnfeeble then
        magicEva = magicEva + target:getMod(mEvaMod) + target:getMod(xi.mod.STATUS_MEVA)
    end

    -- Level correction. Target gets a bonus the higher the level if it's a mob. Never a penalty.
    if
        levelDiff > 0 and
        xi.combat.levelCorrection.isLevelCorrectedZone(actor) and
        not target:isPC()
    then
        magicEva = magicEva + levelDiff * 4
    end

    return magicEva
end

-----------------------------------
-- Magic Hit Rate. The function gets fed the result of both functions above.
-----------------------------------

xi.combat.magicHitRate.calculateMagicHitRate = function(magicAcc, magicEva)
    local magicAccDiff = magicAcc - magicEva

    if magicAccDiff < 0 then
        magicAccDiff = math.floor(magicAccDiff / 2)
    end

    local magicHitRate = utils.clamp(50 + magicAccDiff, 5, 95)

    return magicHitRate
end

-----------------------------------
-- Calculate resist tier.
-----------------------------------

xi.combat.magicHitRate.calculateResistRate = function(actor, target, skillType, spellElement, magicHitRate, rankModifier)
    local targetResistRate = 0 -- The variable we return.
    local targetResistRank = target:getMod(xi.combat.element.resistRankMod[spellElement])

    ----------------------------------------
    -- Handle 'Magic Shield' status effect.
    ----------------------------------------
    if target:hasStatusEffect(xi.effect.MAGIC_SHIELD, 0) then
        return targetResistRate
    end

    ----------------------------------------
    -- Handle target resistance rank.
    ----------------------------------------
    -- Elemental resistance rank.
    if spellElement ~= xi.element.NONE then
        if targetResistRank > 4 then
            targetResistRank = utils.clamp(targetResistRank - rankModifier, 4, 11)
        end
    end

    -- Skillchains lowers target resistance rank by 1.
    local _, skillchainCount = xi.magicburst.formMagicBurst(spellElement, target)

    if skillchainCount > 0 then
        targetResistRank = targetResistRank - 1
    end

    -- TODO: Rayke logic might be needed here, depending on how it's implemented.

    ----------------------------------------
    -- Handle magic hit rate.
    ----------------------------------------
    if targetResistRank >= 10 then
        magicHitRate = 5
    end

    ----------------------------------------
    -- Calculate first 3 resist tiers.
    ----------------------------------------
    local resistTier = 0
    local randomVar  = math.random()

    -- NOTE: Elemental magic evasion 'Boons'.
    -- According to wiki, 1 positive point in the spell element MEVA allows for an additional tier. This would be tier 3, not the resistance rank tier.
    -- However, it also states that a negative value will also prevent full resists, which is redundant. We already wouldnt be eligible for it.

    for tierVar = 3, 1, -1 do
        if randomVar <= (1 - magicHitRate / 100) ^ tierVar then
            resistTier = tierVar
            break
        end
    end

    targetResistRate = 1 / (2 ^ resistTier)

    -- Force 1/8 if target has max resistance rank.
    if targetResistRank >= 11 then
        -- TODO: Immunobreak logic probably goes here

        targetResistRate = 0.125
    end

    -- Force just 1/2 resist tier max if target resistance rank is -3 (150% EEM).
    if targetResistRank <= -3 then -- Very weak.
        targetResistRate = utils.clamp(targetResistRate, 0.5, 1)
    end

    ----------------------------------------
    -- Calculate additional resist tier.
    ----------------------------------------
    if
        not actor:hasStatusEffect(xi.effect.SUBTLE_SORCERY) and -- Subtle sorcery bypasses this tier.
        targetResistRank >= 4 and                               -- Forced only at and after rank 4 (50% EEM).
        skillType == xi.skill.ELEMENTAL_MAGIC                   -- Only applies to nukes.
    then
        targetResistRate = targetResistRate / 2
    end

    return targetResistRate
end
