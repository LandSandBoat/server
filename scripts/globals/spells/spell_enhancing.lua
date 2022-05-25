-----------------------------------
-- Enhancing Spell Utilities
-----------------------------------
require("scripts/globals/spells/parameters")
require("scripts/globals/spell_data")
require("scripts/globals/jobpoints")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------
xi = xi or {}
xi.spells = xi.spells or {}
xi.spells.spell_enhancing = xi.spells.spell_enhancing or {}
-----------------------------------
-- File structure:
-- 2 Basic Functions to calculate final potency. Called by the main function.
-- 1 Basic Function to calculate final duration. Called by the main function.
-- 1 Main function, called by spell scripts.

-- Table variables.
local enhancingTable = xi.spells.parameters.enhancingSpell

-- Enhancing Spell Base Potency function.
xi.spells.spell_enhancing.calculateEnhancingBasePower = function(caster, target, spell, spellId, spellEffect)
    local basePower  = enhancingTable[spellId][4]
    local skillLevel = caster:getSkillLevel(spell:getSkillType())
    ------------------------------------------------------------
    -- Spell specific equations for potency. (Skill and stat)
    ------------------------------------------------------------

    -- TODO: Find a way to replace big if/else chain and still make it look good.

    -- Aquaveil
    if spellEffect == xi.effect.AQUAVEIL then
        if skillLevel >= 200 then -- Cutoff point is estimated. https://www.bg-wiki.com/bg/Aquaveil
            basePower = basePower + 1
        end

    -- Bar-Element
    elseif spellEffect >= xi.effect.BARFIRE and spellEffect <= xi.effect.BARWATER then
        if skillLevel > 300 then
            basePower = 25 + math.floor(skillLevel / 4) -- 150 at 500
        else
            basePower = 40 + math.floor(skillLevel / 5) -- 100 at 300
        end

        basePower = utils.clamp(basePower, 40, 150) -- Max is 150 and min is 40 at skill 0.
    -- Bar-Status
    elseif spellEffect == xi.effect.BARAMNESIA or (spellEffect >= xi.effect.BARSLEEP and spellEffect <= xi.effect.BARVIRUS) then
        basePower = basePower + skillLevel / 50 -- This is WRONG. SO SO WRONG.

    -- Boost-Stat / Gain-Stat
    elseif spellEffect >= xi.effect.STR_BOOST and spellEffect <= xi.effect.CHR_BOOST then
        basePower = basePower + utils.clamp(math.floor((skillLevel - 300) / 10), 0, 20)

    -- Embrava
    elseif spellEffect == xi.effect.EMBRAVA then
        basePower = math.min(skillLevel, 500)

    -- En-Spells (Info from from BG-Wiki) and Auspice
    elseif
        (spellEffect >= xi.effect.ENFIRE and spellEffect <= xi.effect.ENWATER) or
        (spellEffect >= xi.effect.ENFIRE_II and spellEffect <= xi.effect.ENWATER_II) or
        spellEffect == xi.effect.AUSPICE
    then
        if skillLevel > 500 then
            basePower = math.floor(3 * (skillLevel + 50) / 25)
        elseif skillLevel > 400 then
            basePower = math.floor((skillLevel + 20) / 8)
        elseif skillLevel > 150 then
            basePower = math.floor(skillLevel / 20) + 5
        else
            basePower = math.max(math.floor(math.sqrt(skillLevel)) - 1, 0)
        end

    -- Phalanx
    elseif spellEffect == xi.effect.PHALANX then
        if skillLevel > 300 then -- Phalanx I and II over 300 skill
            basePower = utils.clamp(math.floor((skillLevel - 300.5) / 28.5) + 28, 28, 35)
        else
            if spellId == xi.magic.spell.PHALANX then -- Phalanx
                basePower = utils.clamp(math.floor(skillLevel / 10) - 2, 0, 35)
            else -- Phalanx II
                basePower = utils.clamp(math.floor(skillLevel / 25) + 16, 16, 35)
            end
        end

    -- Blaze Spikes (Info from from BG-Wiki)
    elseif spellEffect == xi.effect.BLAZE_SPIKES then
        basePower = utils.clamp(math.floor(math.floor((caster:getStat(xi.mod.INT) + 50) / 12) * (1 + caster:getMod(xi.mod.MATT) / 100)), 1, 25)

    -- Ice Spikes, Shock Spikes (Info from from BG-Wiki)
    elseif spellEffect == xi.effect.ICE_SPIKES or spellEffect == xi.effect.SHOCK_SPIKES then
        basePower = utils.clamp(math.floor(math.floor((caster:getStat(xi.mod.INT) + 50) / 20) * (1 + caster:getMod(xi.mod.MATT) / 100)), 1, 15)

    -- Temper
    elseif spellEffect == xi.effect.MULTI_STRIKES then
        if skillLevel >= 360 then
            basePower = math.floor((skillLevel - 300) / 10)
        end
    end

    return basePower
end

-- Enhancing Spell Final Potency function.
xi.spells.spell_enhancing.calculateEnhancingFinalPower = function(caster, target, spell, basePower, spellGroup, tier, spellEffect)
    local finalPower = basePower

    --------------------
    -- Enboden effect.
    --------------------
    --  Applied before other bonuses, pet buffs seem to not work.
    if not caster:isPet() and target:hasStatusEffect(xi.effect.EMBOLDEN) and spellGroup == xi.magic.spellGroup.WHITE then

        local emboldenPower = 1.5 + target:getJobPointLevel(xi.jp.EMBOLDEN_EFFECT) / 100 -- 1 point in job point category = 1%

        finalPower = math.floor(finalPower * emboldenPower)
    end

    ----------------------------------------
    -- Spell specific modifiers for potency.
    ----------------------------------------

    -- TODO: Find a way to replace big if/else chain and still make it look good.

    -- Bar-Element
    if spellEffect >= xi.effect.BARFIRE and spellEffect <= xi.effect.BARWATER then
        finalPower = finalPower + caster:getMerit(xi.merit.BAR_SPELL_EFFECT) + caster:getMod(xi.mod.BARSPELL_AMOUNT) + caster:getJobPointLevel(xi.jp.BAR_SPELL_EFFECT) * 2

    -- Bar-Status
    elseif spellEffect == xi.effect.BARAMNESIA or (spellEffect >= xi.effect.BARSLEEP and spellEffect <= xi.effect.BARVIRUS) then
        finalPower = finalPower + caster:getMerit(xi.merit.BAR_SPELL_EFFECT) + caster:getMod(xi.mod.BARSPELL_MDEF_BONUS)

    -- Protect/Protectra
    elseif spellEffect == xi.effect.PROTECT then
        if target:getMod(xi.mod.ENHANCES_PROT_SHELL_RCVD) > 0 then
            finalPower = finalPower + (tier * 2)
        end

    -- Refresh
    elseif spellEffect == xi.effect.REFRESH then
        finalPower = finalPower + caster:getMod(xi.mod.ENHANCES_REFRESH)

    -- Regen
    elseif spellEffect == xi.effect.REGEN then
        finalPower = math.ceil(finalPower * (1 + caster:getMod(xi.mod.REGEN_MULTIPLIER) / 100)) -- Bonus HP from Gear.
        finalPower = finalPower + caster:getMerit(xi.merit.REGEN_EFFECT) -- Bonus HP from Merits.
        finalPower = finalPower + caster:getMod(xi.mod.LIGHT_ARTS_REGEN) -- Bonus HP from Light Arts.
        finalPower = finalPower + caster:getMod(xi.mod.REGEN_BONUS)      -- Bonus HP from Job Point Gift.

    -- Shell/Shellra
    elseif spellEffect == xi.effect.SHELL then
        if target:getMod(xi.mod.ENHANCES_PROT_SHELL_RCVD) > 0 then
            finalPower = finalPower + (tier * 39)
        end

    -- -storm
    elseif spellEffect >= xi.effect.FIRESTORM and spellEffect <= xi.effect.VOIDSTORM then
        finalPower = finalPower + caster:getMerit(xi.merit.STORMSURGE) + caster:getMod(xi.mod.STORMSURGE_EFFECT)
    end

    return finalPower
end

-- Enhancing Spell Duration function.
xi.spells.spell_enhancing.calculateEnhancingDuration = function(caster, target, spell, spellId, spellGroup, spellEffect)
    local spellLevel   = enhancingTable[spellId][3]
    local duration     = enhancingTable[spellId][5]
    local useComposure = enhancingTable[spellId][6]
    local targetLevel  = target:getMainLvl()

    -- Deodorize, Invisible and Sneak have a random factor to base duration.
    if spellEffect == xi.effect.DEODORIZE or spellEffect == xi.effect.INVISIBLE or spellEffect == xi.effect.SNEAK then
        duration = duration + 60 * math.random(0, 2)
    end

    --------------------
    -- Embolden, buffs cast by pet do not work.
    --------------------
    if not caster:isPet() and target:hasStatusEffect(xi.effect.EMBOLDEN) and spellGroup == xi.magic.spellGroup.WHITE then
        local emboldenDurationModifier = 0.5 + target:getMod(xi.mod.EMBOLDEN_DURATION) / 100 -- 1 point = 1%
        duration = duration * emboldenDurationModifier
    end

    --------------------
    -- Gear mods
    --------------------
    duration = duration + duration * caster:getMod(xi.mod.ENH_MAGIC_DURATION) / 100

    ------------------------------
    -- Merits and Job Points. (Applicable to all enhancing spells. Prior to multipliers, according to bg-wiki.)
    ------------------------------
    if caster:getMainJob() == xi.job.RDM then
        duration = duration + caster:getMerit(xi.merit.ENHANCING_MAGIC_DURATION) + caster:getJobPointLevel(xi.jp.ENHANCING_DURATION)
    end

    --------------------------------------------------
    -- Spell specific modifiers for duration.
    --------------------------------------------------
    -- Regen
    if spellEffect == xi.effect.REGEN then
        duration = duration + caster:getMod(xi.mod.REGEN_DURATION)
        duration = duration + caster:getJobPointLevel(xi.jp.REGEN_DURATION) * 3

    -- Invisible
    elseif spellEffect == xi.effect.INVISIBLE then
        duration = duration + target:getMod(xi.mod.INVISIBLE_DURATION)

    -- Sneak
    elseif spellEffect == xi.effect.SNEAK then
        duration = duration + target:getMod(xi.mod.SNEAK_DURATION)
    end

    --------------------
    -- Status Effects
    --------------------
    -- Composure
    if useComposure and caster:hasStatusEffect(xi.effect.COMPOSURE) and caster:getID() == target:getID() then
        duration = duration * 3
    end

    -- Perpetuance (Doesnt affect spikes and other Black magic enhancements)
    if caster:hasStatusEffect(xi.effect.PERPETUANCE) and spellGroup == xi.magic.spellGroup.WHITE then
        duration  = duration * 2
    end

    ------------------------------
    -- Level penalty to duration.
    ------------------------------
    if targetLevel < spellLevel then
        duration = duration * targetLevel / spellLevel
    end

    return duration
end

-- Main function for Enhancing Spells.
xi.spells.spell_enhancing.useEnhancingSpell = function(caster, target, spell)
    local spellId    = spell:getID()
    local spellGroup = spell:getSpellGroup()
    local MDB        = 0
    -- Get Variables from Parameters Table.
    local tier            = enhancingTable[spellId][1]
    local spellEffect     = enhancingTable[spellId][2]
    local alwaysOverwrite = enhancingTable[spellId][7]
    local tickTime        = enhancingTable[spellId][8]

    ------------------------------------------------------------
    -- Handle exceptions and weird behaviour here, before calculating anything.
    ------------------------------------------------------------

    -- TODO: Find a way to replace big if/else chain and still make it look good.

    -- Bar-Element (They use addStatusEffect argument 6. Bar-Status current implementation doesn't.)
    if spellEffect >= xi.effect.BARFIRE and spellEffect <= xi.effect.BARWATER then
        MDB = caster:getMerit(xi.merit.BAR_SPELL_EFFECT) + caster:getMod(xi.mod.BARSPELL_MDEF_BONUS)
    -- Embrava
    elseif spellEffect == xi.effect.EMBRAVA then
        -- If Tabula Rasa wears before spell goes off, no Embrava for you!
        if not caster:hasStatusEffect(xi.effect.TABULA_RASA) then
            spell:setMsg(xi.msg.basic.MAGIC_CANNOT_CAST)
            return 0
        end

    -- Refresh
    elseif spellEffect == xi.effect.REFRESH then
        if target:hasStatusEffect(xi.effect.SUBLIMATION_ACTIVATED) or target:hasStatusEffect(xi.effect.SUBLIMATION_COMPLETE) then
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
            return 0
        end

    -- Boost-Stat / Gain-Stat
    elseif spellEffect >= xi.effect.STR_BOOST and spellEffect <= xi.effect.CHR_BOOST then
        -- Only one Boost Effect can be active at once, so if the player has any we have to cancel & overwrite
        local effectOverwrite =
        {
            xi.effect.STR_BOOST,
            xi.effect.DEX_BOOST,
            xi.effect.VIT_BOOST,
            xi.effect.AGI_BOOST,
            xi.effect.INT_BOOST,
            xi.effect.MND_BOOST,
            xi.effect.CHR_BOOST
        }

        for i, effectValue in ipairs(effectOverwrite) do
            if target:hasStatusEffect(effectValue) then
                target:delStatusEffect(effectValue)
            end
        end

    -- -storm spells
    elseif spellEffect >= xi.effect.FIRESTORM and spellEffect <= xi.effect.VOIDSTORM then
        -- Only one storm effect can be active at once, so if the player has any we have to cancel & overwrite
        local effectOverwrite =
        {
            xi.effect.FIRESTORM,
            xi.effect.SANDSTORM,
            xi.effect.RAINSTORM,
            xi.effect.WINDSTORM,
            xi.effect.HAILSTORM,
            xi.effect.THUNDERSTORM,
            xi.effect.AURORASTORM,
            xi.effect.VOIDSTORM
        }

        for i, effectValue in ipairs(effectOverwrite) do
            if target:hasStatusEffect(effectValue) then
                target:delStatusEffect(effectValue)
            end
        end
    end

    --------------------------------------------------
    -- Calculate Spell Pottency and Duration.
    --------------------------------------------------
    local basePower  = xi.spells.spell_enhancing.calculateEnhancingBasePower(caster, target, spell, spellId, spellEffect)
    local finalPower = xi.spells.spell_enhancing.calculateEnhancingFinalPower(caster, target, spell, basePower, spellGroup, tier, spellEffect)
    local duration   = xi.spells.spell_enhancing.calculateEnhancingDuration(caster, target, spell, spellId, spellGroup, spellEffect)

    ------------------------------
    -- Handle Status Effects, Embolden buffs can only be applied by player, so do not remove embolden..
    ------------------------------
    if not caster:isPet() and target:hasStatusEffect(xi.effect.EMBOLDEN) and spellGroup == xi.magic.spellGroup.WHITE then
        target:delStatusEffectSilent(xi.effect.EMBOLDEN)
    end

    ------------------------------------------------------------
    -- Change message when higher effect or "Always overwrite".
    ------------------------------------------------------------
    if alwaysOverwrite then
        target:delStatusEffect(spellEffect)
        target:addStatusEffect(spellEffect, finalPower, tickTime, duration, 0, MDB, tier)
    else
        if target:addStatusEffect(spellEffect, finalPower, tickTime, duration, 0, MDB, tier) then
            spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- No effect.
        end
    end

    return spellEffect
end
