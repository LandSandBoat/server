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
-- 2 Basic Functions called by the main function.

-- Table variables.
local enhancingTable = xi.spells.parameters.enhancingSpell

-- Enhancing Spell Potency function. (1/2)
xi.spells.spell_enhancing.calculateEnhancingPower = function(caster, target, spell, spellId, spellGroup, tier, spellEffect)
    local power      = enhancingTable[spellId][5]
    local skillLevel = caster:getSkillLevel(spellEffect)

    ------------------------------------------------------------
    -- Spell specific equations for potency. (Skill and MND)
    ------------------------------------------------------------
    -- Aquaveil
    if spellEffect == xi.effect.AQUAVEIL then
        if skillLevel >= 200 then -- Cutoff point is estimated. https://www.bg-wiki.com/bg/Aquaveil
            power = power + 1
        end

    -- Bar-Element
    elseif
        spellEffect == xi.effect.BARAERO or spellEffect == xi.effect.BARBLIZZARD or spellEffect == xi.effect.BARFIRE or
        spellEffect == xi.effect.BARSTONE or spellEffect == xi.effect.BARTHUNDER or spellEffect == xi.effect.BARWATER
    then
        if skillLevel > 300 then
            power = 25 + math.floor(skillLevel / 4) -- 150 at 500
        else
            power = 40 + math.floor(skillLevel / 5) -- 100 at 300
        end

        power = utils.clamp(power, 40, 150) -- Max is 150 and min is 40 at skill 0.

    -- Bar-Status
    elseif
        spellEffect == xi.effect.BARAMNESIA or spellEffect == xi.effect.BARBLIND or spellEffect == xi.effect.BARPARALYZE or spellEffect == xi.effect.BARPETRIFY or
        spellEffect == xi.effect.BARPOISON or spellEffect == xi.effect.BARSILENCE or spellEffect == xi.effect.BARSLEEP or spellEffect == xi.effect.BARVIRUS
    then
        power = power + skillLevel / 50 -- This is WRONG. SO SO WRONG.

    -- Boost-Stat / Gain-Stat
    elseif
        spellEffect == xi.effect.STR_BOOST or spellEffect == xi.effect.DEX_BOOST or spellEffect == xi.effect.VIT_BOOST or spellEffect == xi.effect.AGI_BOOST or
        spellEffect == xi.effect.INT_BOOST or spellEffect == xi.effect.MND_BOOST or spellEffect == xi.effect.CHR_BOOST
    then
        power = power + utils.clamp(math.floor((skillLevel - 300) / 10), 0, 20)
    end

    --------------------
    -- Enboden effect.
    --------------------
    --  Applied before other bonuses. TODO: Job points further enhances Embolden bonus.
    if target:hasStatusEffect(xi.effect.EMBOLDEN) and spellGroup == xi.magic.spellGroup.WHITE then
        power = math.floor(power * 1.5)
    end

    ----------------------------------------
    -- Spell specific modifiers for potency.
    ----------------------------------------
    -- Bar-Element
    if
        spellEffect == xi.effect.BARAERO or spellEffect == xi.effect.BARBLIZZARD or spellEffect == xi.effect.BARFIRE or
        spellEffect == xi.effect.BARSTONE or spellEffect == xi.effect.BARTHUNDER or spellEffect == xi.effect.BARWATER
    then
        power = power + caster:getMerit(xi.merit.BAR_SPELL_EFFECT) + caster:getMod(xi.mod.BARSPELL_AMOUNT) + caster:getJobPointLevel(xi.jp.BAR_SPELL_EFFECT) * 2

    -- Bar-Element
    elseif
        spellEffect == xi.effect.BARAMNESIA or spellEffect == xi.effect.BARBLIND or spellEffect == xi.effect.BARPARALYZE or spellEffect == xi.effect.BARPETRIFY or
        spellEffect == xi.effect.BARPOISON or spellEffect == xi.effect.BARSILENCE or spellEffect == xi.effect.BARSLEEP or spellEffect == xi.effect.BARVIRUS
    then
        power = power + caster:getMerit(xi.merit.BAR_SPELL_EFFECT) + caster:getMod(xi.mod.BARSPELL_MDEF_BONUS)

    -- Protect/Protectra
    elseif spellEffect == xi.effect.PROTECT then
        if target:getMod(xi.mod.ENHANCES_PROT_SHELL_RCVD) > 0 then
            power = power + (tier * 2)
        end

    -- Refresh
    elseif spellEffect == xi.effect.REFRESH then
        power = power + caster:getMod(xi.mod.ENHANCES_REFRESH)

    -- Regen
    elseif spellEffect == xi.effect.REGEN then
        power = math.ceil(power * (1 + caster:getMod(xi.mod.REGEN_MULTIPLIER) / 100)) -- Bonus HP from Gear.
        power = power + caster:getMerit(xi.merit.REGEN_EFFECT) -- Bonus HP from Merits.
        power = power + caster:getMod(xi.mod.LIGHT_ARTS_REGEN) -- Bonus HP from Light Arts.
        power = power + caster:getMod(xi.mod.REGEN_BONUS)      -- Bonus HP from Job Point Gift.

    -- Shell/Shellra
    elseif xi.effect.SHELL then
        if target:getMod(xi.mod.ENHANCES_PROT_SHELL_RCVD) > 0 then
            power = power + (tier * 39)
        end
    end

    ----------
    -- Finish
    ----------
    return power
end

-- Enhancing Spell Duration function. (2/2)
xi.spells.spell_enhancing.calculateEnhancingDuration = function(caster, target, spell, spellId, spellGroup, spellEffect, magicSkill)
    local spellLevel   = enhancingTable[spellId][4]
    local duration     = enhancingTable[spellId][6]
    local useComposure = enhancingTable[spellId][7]
    local targetLevel  = target:getMainLvl()

    if magicSkill == xi.skill.ENHANCING_MAGIC then
        --------------------
        -- Embolden
        --------------------
        if target:hasStatusEffect(xi.effect.EMBOLDEN) and spellGroup == xi.magic.spellGroup.WHITE then
            duration = duration / 2
        end

        --------------------
        -- Gear mods
        --------------------
        duration = duration + duration * caster:getMod(xi.mod.ENH_MAGIC_DURATION) / 100

        ------------------------------
        -- Merits and Job Points. (Applicable to all enhancing spells. Prior to multipliers, according to bg-wiki.)
        ------------------------------
        if caster:getJob() == xi.job.RDM then
            duration = duration + caster:getMerit(xi.merit.ENHANCING_MAGIC_DURATION) + caster:getJobPointLevel(xi.jp.ENHANCING_DURATION)
        end

        --------------------------------------------------
        -- Spell specific modifiers for duration.
        --------------------------------------------------
        -- Regen
        if spellEffect == xi.effect.REGEN then
            duration = duration + caster:getMod(xi.mod.REGEN_DURATION)
            duration = duration + caster:getJobPointLevel(xi.jp.REGEN_DURATION) * 3
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

    elseif magicSkill == xi.skill.NINJUTSU then
        -- Do stuff
    end

    ------------------------------
    -- Level penalty to duration.
    ------------------------------
    if targetLevel < spellLevel then
        duration = duration * targetLevel / spellLevel
    end

    ----------
    -- Finish
    ----------
    return duration
end

-- Main function for Enhancing Spells.
xi.spells.spell_enhancing.useEnhancingSpell = function(caster, target, spell)
    local spellId    = spell:getID()
    local spellGroup = spell:getSpellGroup()
    local MDB        = 0
    -- Get Variables from Parameters Table.
    local tier            = enhancingTable[spellId][1]
    local magicSkill      = enhancingTable[spellId][2]
    local spellEffect     = enhancingTable[spellId][3]
    local alwaysOverwrite = enhancingTable[spellId][8]

    ------------------------------------------------------------
    -- Handle exceptions here, before calculating anything.
    ------------------------------------------------------------
    -- Bar-Element (They use addStatusEffect argument 6. Bar-Status current implementation doesn't.)
    if
        spellEffect == xi.effect.BARAERO or spellEffect == xi.effect.BARBLIZZARD or spellEffect == xi.effect.BARFIRE or
        spellEffect == xi.effect.BARSTONE or spellEffect == xi.effect.BARTHUNDER or spellEffect == xi.effect.BARWATER
    then
        MDB = caster:getMerit(xi.merit.BAR_SPELL_EFFECT) + caster:getMod(xi.mod.BARSPELL_MDEF_BONUS)

    -- Refresh
    elseif spellEffect == xi.effect.REFRESH then
        if target:hasStatusEffect(xi.effect.SUBLIMATION_ACTIVATED) or target:hasStatusEffect(xi.effect.SUBLIMATION_COMPLETE) then
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
            return 0
        end

    -- Boost-Stat / Gain-Stat
    elseif
        spellEffect == xi.effect.STR_BOOST or spellEffect == xi.effect.DEX_BOOST or spellEffect == xi.effect.VIT_BOOST or spellEffect == xi.effect.AGI_BOOST or
        spellEffect == xi.effect.INT_BOOST or spellEffect == xi.effect.MND_BOOST or spellEffect == xi.effect.CHR_BOOST
    then
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
    end

    --------------------------------------------------
    -- Calculate Spell Pottency and Duration.
    --------------------------------------------------
    local power    = xi.spells.spell_enhancing.calculateEnhancingPower(caster, target, spell, spellId, spellGroup, tier, spellEffect)
    local duration = xi.spells.spell_enhancing.calculateEnhancingDuration(caster, target, spell, spellId, spellGroup, spellEffect, magicSkill)

    ------------------------------
    -- Handle Status Effects.
    ------------------------------
    if caster:hasStatusEffect(xi.effect.EMBOLDEN) and magicSkill == xi.skill.ENHANCING_MAGIC then
        caster:delStatusEffect(xi.effect.EMBOLDEN)
    end

    ------------------------------------------------------------
    -- Change message when higher effect or "Always overwrite".
    ------------------------------------------------------------
    if alwaysOverwrite then
        target:delStatusEffect(spellEffect)
        target:addStatusEffect(spellEffect, power, 0, duration, 0, MDB, tier)
    else
        if target:addStatusEffect(spellEffect, power, 0, duration, 0, MDB, tier) then
            spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- No effect.
        end
    end

    return spellEffect
end
