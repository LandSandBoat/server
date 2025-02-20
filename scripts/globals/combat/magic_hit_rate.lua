-----------------------------------
-- Global file for magic based skills magic hit rate.
-----------------------------------
require('scripts/globals/combat/element_tables')
require('scripts/globals/combat/level_correction')
require('scripts/globals/combat/skill_ranks')
require('scripts/globals/combat/status_effect_tables')
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.magicHitRate = xi.combat.magicHitRate or {}

-----------------------------------
-- Calculate Actor Magic Accuracy
-----------------------------------

-- Magic Accuracy from spell's skill.
local function magicAccuracyFromSkill(actor, skillType, skillRank)
    local magicAcc = 0

    -- For known skills.
    if skillType > 0 then
        magicAcc = actor:getSkillLevel(skillType)

        if skillType == xi.skill.SINGING then
            if actor:isPC() then
                -- Add ranged skill level ONLY if it's an instrument.
                local rangeType = actor:getWeaponSkillType(xi.slot.RANGED)

                -- String instruments have half the skill effectiveness and amplify the AoE in exchange.
                if rangeType == xi.skill.WIND_INSTRUMENT then
                    magicAcc = magicAcc + actor:getSkillLevel(rangeType)
                elseif rangeType == xi.skill.STRING_INSTRUMENT then
                    magicAcc = magicAcc + math.floor(actor:getSkillLevel(rangeType) / 2)
                end

            else
                magicAcc = magicAcc * 2
            end
        end

    -- Made for bolts. Will probably see other uses.
    elseif skillRank > 0 then
        magicAcc = xi.combat.skillLevel.getSkillCap(actor:getMainLvl(), skillRank)

    -- For mob skills / additional effects which don't have a skill.
    else
        magicAcc = xi.combat.skillLevel.getSkillCap(actor:getMainLvl(), xi.skillRank.A_PLUS)
    end

    return magicAcc
end

-- Magic Accuracy from spell's element.
local function magicAccuracyFromElement(actor, actionElement)
    local magicAcc = 0

    if actionElement > xi.element.NONE then
        magicAcc = actor:getMod(xi.combat.element.getElementalMACCModifier(actionElement)) + actor:getMod(xi.combat.element.getElementalAffinityMACCModifier(actionElement)) * 10
    end

    return magicAcc
end

-- Magic Accuracy from Stat Difference between caster and target.
local function magicAccuracyFromStatDifference(actor, target, statUsed)
    if statUsed == 0 then
        return 0
    end

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
local function magicAccuracyFromStatusEffects(actor, spellGroup, skillType, actionElement)
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
        actionElement > 0 and
        (actorWeather == xi.combat.element.getAssociatedSingleWeather(actionElement) or actorWeather == xi.combat.element.getAssociatedDoubleWeather(actionElement))
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
        actionElement > 0
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
local function magicAccuracyFromMerits(actor, skillType, actionElement)
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
                actionElement >= xi.element.FIRE and
                actionElement <= xi.element.WATER
            then
                magicAcc = actor:getMerit(xi.combat.element.getElementalAccuracyMerit(actionElement))
            end

            -- Category 2
            magicAcc = magicAcc + actor:getMerit(xi.merit.MAGIC_ACCURACY)
        end,

        [xi.job.BRD] = function()
            if
                skillType == xi.skill.SINGING and
                actor:hasStatusEffect(xi.effect.TROUBADOUR)
            then
                magicAcc = 64 * (actor:getMerit(xi.merit.TROUBADOUR) / 25 - 1)
            end
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

        [xi.job.BRD] = function()
            if skillType == xi.skill.SINGING then
                magicAcc = actor:getJobPointLevel(xi.jp.SONG_ACC_BONUS)
            end
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
local function magicAccuracyFromMagicBurst(target, actionElement, statUsed)
    if statUsed == 0 then
        return 0
    end

    local magicAcc           = 0
    local _, skillchainCount = xi.magicburst.formMagicBurst(actionElement, target)

    if skillchainCount > 0 then
        magicAcc = 100
    end

    return magicAcc
end

-- Magic Accuracy from Day's Element.
local function magicAccuracyFromDayElement(actor, actionElement)
    local magicAcc = 0

    if
        actionElement ~= xi.element.NONE and
        (math.random(1, 100) <= 33 or actor:getMod(xi.combat.element.getForcedDayOrWeatherBonusModifier(actionElement)) >= 1)
    then
        local dayElement = VanadielDayElement()

        -- Strong day.
        if dayElement == actionElement then
            magicAcc = magicAcc + 5

        -- Weak day.
        elseif dayElement == xi.combat.element.getOppositeElement(actionElement) then
            magicAcc = magicAcc - 5
        end
    end

    return magicAcc
end

-- Magic Accuracy from Weather's Element.
local function magicAccuracyFromWeatherElement(actor, actionElement)
    local magicAcc = 0

    -- Calculate if weather bonus triggers.
    if
        actionElement ~= xi.element.NONE and
        (math.random(1, 100) <= 33 or actor:getMod(xi.combat.element.getForcedDayOrWeatherBonusModifier(actionElement)) >= 1)
    then
        local actorWeather = actor:getWeather()

        -- Strong weathers.
        if actorWeather == xi.combat.element.getAssociatedSingleWeather(actionElement) then
            magicAcc = magicAcc + actor:getMod(xi.mod.IRIDESCENCE) * 5 + 5
        elseif actorWeather == xi.combat.element.getAssociatedDoubleWeather(actionElement) then
            magicAcc = magicAcc + actor:getMod(xi.mod.IRIDESCENCE) * 5 + 10

        -- Weak weathers.
        elseif actorWeather == xi.combat.element.getOppositeSingleWeather(actionElement) then
            magicAcc = magicAcc - actor:getMod(xi.mod.IRIDESCENCE) * 5 - 5
        elseif actorWeather == xi.combat.element.getOppositeDoubleWeather(actionElement) then
            magicAcc = magicAcc - actor:getMod(xi.mod.IRIDESCENCE) * 5 - 10
        end
    end

    return magicAcc
end

-- Magic Accuracy from Food.
local function magicAccuracyFromFoodMultiplier(actor)
    local magicAcc          = 1
    local foodMagicAccBonus = actor:getMod(xi.mod.FOOD_MACCP) / 100
    local foodMagicAccCap   = actor:getMod(xi.mod.FOOD_MACC_CAP) / 100

    if foodMagicAccCap > 0 then
        foodMagicAccBonus = utils.clamp(foodMagicAccBonus, 0, foodMagicAccCap)
    end

    magicAcc = magicAcc + foodMagicAccBonus

    return magicAcc
end

local function magicAccuracyFromSoulVoiceMultiplier(actor, skillType, effectId)
    local effectTable =
    set{
        xi.effect.SLEEP_I, -- Lullabies
        xi.effect.NONE,    -- Magic Finale
        xi.effect.CHARM_I  -- Maiden's Virellai
    }

    if
        effectTable[effectId] and
        skillType == xi.skill.SINGING
    then
        if actor:hasStatusEffect(xi.effect.SOUL_VOICE) then
            return 2
        elseif actor:hasStatusEffect(xi.effect.MARCATO) then
            return 1.5
        end
    end

    return 1
end

-- Global function to calculate total magicc accuracy.
xi.combat.magicHitRate.calculateActorMagicAccuracy = function(actor, target, spellGroup, skillType, skillRank, actionElement, statUsed, effectId, bonusMacc)
    local finalMagicAcc = 0

    local magicAccBase      = actor:getMod(xi.mod.MACC) + actor:getILvlMacc(xi.slot.MAIN)
    local magicAccSkill     = magicAccuracyFromSkill(actor, skillType, skillRank)
    local magicAccElement   = magicAccuracyFromElement(actor, actionElement)
    local magicAccStatDiff  = magicAccuracyFromStatDifference(actor, target, statUsed)
    local magicAccEffects   = magicAccuracyFromStatusEffects(actor, spellGroup, skillType, actionElement)
    local magicAccMerits    = magicAccuracyFromMerits(actor, skillType, actionElement)
    local magicAccJobPoints = magicAccuracyFromJobPoints(actor, spellGroup, skillType)
    local magicAccBurst     = magicAccuracyFromMagicBurst(target, actionElement, statUsed)
    local magicAccDay       = magicAccuracyFromDayElement(actor, actionElement)
    local magicAccWeather   = magicAccuracyFromWeatherElement(actor, actionElement)

    -- Multipliers
    local magicAccFoodFactor      = magicAccuracyFromFoodMultiplier(actor)
    local magicAccSoulVoiceFactor = magicAccuracyFromSoulVoiceMultiplier(actor, skillType, effectId)

    -- Add up food magic accuracy.
    finalMagicAcc = magicAccBase + magicAccSkill + magicAccElement + magicAccStatDiff + magicAccEffects + magicAccMerits + magicAccJobPoints + magicAccBurst + magicAccDay + magicAccWeather + bonusMacc
    finalMagicAcc = math.floor(finalMagicAcc * magicAccFoodFactor * magicAccSoulVoiceFactor)

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

xi.combat.magicHitRate.calculateTargetMagicEvasion = function(actor, target, actionElement, magicEvasionModifier, rankModifier)
    local magicEva   = target:getMod(xi.mod.MEVA) -- Base MACC.
    local resistRank = 0 -- Elemental specific Resistance rank. Acts as multiplier to base MACC.
    local resMod     = 0 -- Elemental specific magic evasion. Acts as a additive bonus to base MACC after affected by resistance rank.

    -- Elemental magic evasion.
    if actionElement ~= xi.element.NONE then
        -- Mod set in database for mobs. Base 0 means not resistant nor weak. Bar-element spells included here.
        resMod     = target:getMod(xi.combat.element.getElementalMEVAModifier(actionElement))
        resistRank = utils.clamp(target:getMod(xi.combat.element.getElementalResistanceRankModifier(actionElement)), -3, 11)

        if resistRank > 4 then
            resistRank = utils.clamp(resistRank - rankModifier, 4, 11)
        end

        magicEva = math.floor(magicEva * resistRankMultiplier[resistRank]) + resMod
    end

    -- Magic evasion against specific status effects.
    if magicEvasionModifier > 0 then
        magicEva = magicEva + target:getMod(magicEvasionModifier) + target:getMod(xi.mod.STATUS_MEVA)
    end

    -- Level correction. Target gets a bonus the higher the level if it's a mob. Never a penalty.
    if
        not target:isPC() and
        xi.combat.levelCorrection.isLevelCorrectedZone(actor)
    then
        magicEva = magicEva + utils.clamp(target:getMainLvl() - actor:getMainLvl(), 0, 100) * 4
    end

    return magicEva
end

-----------------------------------
-- Magic Hit Rate. The function gets fed the result of both functions above.
-----------------------------------

xi.combat.magicHitRate.calculateMagicHitRate = function(magicAcc, magicEva)
    local magicHitRate = magicAcc - magicEva

    if magicHitRate < 0 then
        magicHitRate = math.floor(magicHitRate / 2)
    end

    magicHitRate = utils.clamp((50 + magicHitRate) / 100, 0.05, 0.95)

    return magicHitRate
end

-----------------------------------
-- Calculate resist tier.
-----------------------------------

xi.combat.magicHitRate.calculateResistanceFactor = function(actor, target, actionElement, magicHitRate, rankModifier)
    local targetResistRate = 1 -- The variable we return.

    ----------------------------------------
    -- Handle 'Magic Shield' status effect.
    ----------------------------------------
    if target:hasStatusEffect(xi.effect.MAGIC_SHIELD, 0) then
        return 0
    end

    ----------------------------------------
    -- Handle non elemental magic or user error.
    ----------------------------------------
    if
        not actionElement or                -- You shouldnt be using this function.
        actionElement <= xi.element.NONE or -- Non elemental magic (ex. Player Meteor) cannot be resisted.
        actionElement > xi.element.DARK     -- That's not even an element.
    then
        return 1
    end

    ----------------------------------------
    -- Handle target resistance rank.
    ----------------------------------------
    local targetResistRank = target:getMod(xi.combat.element.getElementalResistanceRankModifier(actionElement)) or 0

    if targetResistRank > 4 then
        targetResistRank = utils.clamp(targetResistRank - rankModifier, 4, 11)
    end

    ----------------------------------------
    -- Force 1/8 if target has max resistance rank.
    ----------------------------------------
    if targetResistRank >= 11 then
        return 0.0625
    end

    ----------------------------------------
    -- Handle magic hit rate.
    ----------------------------------------
    if targetResistRank >= 10 then
        magicHitRate = 0.05
    end

    ----------------------------------------
    -- Calculate first 3 resist tiers.
    -- Notes: https://wiki-ffo-jp.translate.goog/html/795.html?_x_tr_sl=ja&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=sc
    ----------------------------------------
    -- Calculate max allowed resist tier.
    local maxResistTier = 3

    -- Players: Affected by element shown in equipment screen.
    if target:isPC() then
        local playerElementalEvasion = target:getMod(xi.combat.element.getElementalMEVAModifier(actionElement)) or 0

        if playerElementalEvasion < 0 then
            maxResistTier = 1
        elseif playerElementalEvasion == 0 then
            maxResistTier = 2
        end

    -- Non-players: Affected by resistance rank.
    else
        if targetResistRank <= -3 then
            maxResistTier = 1
        end
    end

    -- Calculate resist tier.
    local resistTier = 3
    local randomVar  = math.random() -- High number = More resist.

    if randomVar <= magicHitRate then
        resistTier = 0
    elseif randomVar <= 2 * magicHitRate - magicHitRate ^ 2 then
        resistTier = 1
    elseif randomVar <= magicHitRate ^ 3 - 3 * magicHitRate ^ 2 + 3 * magicHitRate then
        resistTier = 2
    end

    resistTier = utils.clamp(resistTier, 0, maxResistTier)

    targetResistRate = 1 / (2 ^ resistTier)

    return targetResistRate
end

-----------------------------------
-- Resist rate helper function.
-----------------------------------

xi.combat.magicHitRate.calculateResistRate = function(actor, target, spellGroup, skillType, skillRank, actionElement, statUsed, effectId, bonusMacc)
    local magicEvasionModifier = 0
    local rankModifier         = 0

    -- Prepare parameters
    if effectId and effectId > 0 then
        magicEvasionModifier = xi.combat.statusEffect.getAssociatedMagicEvasionModifier(effectId)
        rankModifier         = target:getMod(xi.combat.statusEffect.getAssociatedImmunobreakModifier(effectId))
    end

    -- Get Actor Magic Accuracy and target Magic Evasion
    local magicAcc     = xi.combat.magicHitRate.calculateActorMagicAccuracy(actor, target, spellGroup, skillType, skillRank, actionElement, statUsed, effectId, bonusMacc)
    local magicEva     = xi.combat.magicHitRate.calculateTargetMagicEvasion(actor, target, actionElement, magicEvasionModifier, rankModifier)
    local magicHitRate = xi.combat.magicHitRate.calculateMagicHitRate(magicAcc, magicEva)
    local resistRate   = xi.combat.magicHitRate.calculateResistanceFactor(actor, target, actionElement, magicHitRate, rankModifier)

    return resistRate
end
