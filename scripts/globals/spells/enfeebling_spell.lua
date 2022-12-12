-----------------------------------
-- Enfeebling Spell Utilities
-- Used for spells that deal negative status effects upon targets.
-----------------------------------
require("scripts/globals/damage/magic_hit_rate")
require("scripts/globals/jobpoints")
require("scripts/globals/magicburst")
require("scripts/globals/msg")
require("scripts/globals/settings")
require("scripts/globals/spell_data")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------
xi = xi or {}
xi.spells = xi.spells or {}
xi.spells.enfeebling = xi.spells.enfeebling or {}
-----------------------------------

local m = xi.mod
local e = xi.effect

local pTable =
{   --                              1           2          3             4               5      6    7         8       9           10       11
    --               [Spell ID] = { Effect,     Stat-Used, Resist-Mod,   MEVA-Mod,       Power, DoT, Duration, Resist, Bonus-MACC, Potency, Overwrite },
    [xi.magic.spell.SILENCE   ] = { e.SILENCE,  m.MND,     m.SILENCERES, m.SILENCE_MEVA,     1,   0,      120,      2,          0,   false,     false },
    [xi.magic.spell.SILENCEGA ] = { e.SILENCE,  m.MND,     m.SILENCERES, m.SILENCE_MEVA,     1,   0,      120,      2,          0,   false,     false },

    [xi.magic.spell.SLEEP     ] = { e.SLEEP_I,  m.INT,     m.SLEEPERES,  m.SLEEP_MEVA,       1,   0,       60,      2,          0,   false,     false },
    [xi.magic.spell.SLEEP_II  ] = { e.SLEEP_I,  m.INT,     m.SLEEPERES,  m.SLEEP_MEVA,       2,   0,       60,      2,          0,   false,     false },
    [xi.magic.spell.SLEEPGA   ] = { e.SLEEP_II, m.INT,     m.SLEEPERES,  m.SLEEP_MEVA,       1,   0,       90,      2,          0,   false,     false },
    [xi.magic.spell.SLEEPGA_II] = { e.SLEEP_II, m.INT,     m.SLEEPERES,  m.SLEEP_MEVA,       2,   0,       90,      2,          0,   false,     false },

    -- [xi.magic.spell.SLOW      ] = { e.SLOW,     m.MND,     m.SLOWRES,    m.SLOW_MEVA,        X,   0,      180,      2,          0,    true,      true },
}

-- Calculates if target has resistance traits or gear mods that can nullify effects.
xi.spells.enfeebling.calculateTraitTrigger = function(caster, target, spellId)
    local specificModPower = target:getMod(pTable[spellId][3])
    local globalModPower   = target:getMod(xi.mod.STATUSRES)
    local totalPower       = specificModPower + globalModPower

    if totalPower > 0 then
        local roll = math.random(1, 100)
        totalPower = totalPower + 5

        if caster:isNM() then
            totalPower = totalPower / 2
        end

        if roll <= totalPower then
            return true
        end
    end

    return false
end

xi.spells.enfeebling.calculatePotency = function(caster, target, spellId, skillType, statUsed)
    local potency  = pTable[spellId][5]
    local statDiff = caster:getStat(statUsed) - target:getStat(statUsed)

    potency = potency * statDiff

    if
        caster:hasStatusEffect(xi.effect.SABOTEUR) and
        skillType == xi.skill.ENFEEBLING_MAGIC
    then
        if target:isNM() then
            potency = potency * (1.3 + caster:getMod(xi.mod.ENHANCES_SABOTEUR))
        else
            potency = potency * (2 + caster:getMod(xi.mod.ENHANCES_SABOTEUR))
        end
    end

    return math.floor(potency)
end

xi.spells.enfeebling.calculateDuration = function(caster, target, spellId)
    local duration = pTable[spellId][7]

    if caster:hasStatusEffect(xi.effect.SABOTEUR) then
        if target:isNM() then
            duration = duration * 1.25
        else
            duration = duration * 2
        end
    end

    -- After Saboteur according to bg-wiki
    if caster:getMainJob() == xi.job.RDM then
        -- RDM Merit: Enfeebling Magic Duration
        duration = duration + caster:getMerit(xi.merit.ENFEEBLING_MAGIC_DURATION)

        -- RDM Job Point: Enfeebling Magic Duration
        duration = duration + caster:getJobPointLevel(xi.jp.ENFEEBLE_DURATION)

        -- RDM Job Point: Stymie effect
        if caster:hasStatusEffect(xi.effect.STYMIE) then
            duration = duration + caster:getJobPointLevel(xi.jp.STYMIE_EFFECT)
        end
    end

    return math.floor(duration)
end

xi.spells.enfeebling.useEnfeeblingSpell = function(caster, target, spell)
    local spellId        = spell:getID()
    local spellEffect    = pTable[spellId][1]

    ------------------------------
    -- STEP 1: Check spell overwrite.
    ------------------------------
    if
        not pTable[spellId][11] and
        target:hasStatusEffect(spellEffect)
    then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)

        return spellEffect
    end

    ------------------------------
    -- STEP 2: Check trait nullification.
    ------------------------------
    local traitTrigger = xi.spells.enfeebling.calculateTraitTrigger(caster, target, spellId)

    if traitTrigger then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST_2) -- TODO: Confirm correct message.

        return spellEffect
    end

    ------------------------------
    -- STEP 3: Calculate resist tiers.
    ------------------------------
    local skillType    = spell:getSkillType()
    local spellElement = spell:getElement()
    local statUsed     = pTable[spellId][2]
    local mEvaMod      = pTable[spellId][4]
    local resistStages = pTable[spellId][8]
    -- local spellMacc    = pTable[spellId][9] TODO: Add support in magic accuracy calculations for spell specific macc

    -- Magic Hit Rate calculations.
    local magicAcc     = xi.damage.magicHitRate.calculateCasterMagicAccuracy(caster, target, spell, skillType, spellElement, statUsed)
    local magicEva     = xi.damage.magicHitRate.calculateTargetMagicEvasion(caster, target, spellElement, true, mEvaMod)
    local magicHitRate = xi.damage.magicHitRate.calculateMagicHitRate(magicAcc, magicEva)

    -- Calculate individualy resists for potency and duration.
    local resistDuration = xi.damage.magicHitRate.calculateResistRate(magicHitRate, resistStages)

    ------------------------------
    -- STEP 4: Calculate Potency and Duration.
    ------------------------------
    if resistDuration > 1 / (2 ^ resistStages) then
        -- Calculate Duration.
        local duration = xi.spells.enfeebling.calculateDuration(caster, target, spellId)
        duration       = math.floor(duration * resistDuration)

        -- Calculate potency.
        local potency        = pTable[spellId][4]
        local resistPotency  = 1

        -- If potency is variable.
        if pTable[spellId][10] then
            resistPotency  = xi.damage.magicHitRate.calculateResistRate(magicHitRate, resistStages)
            potency        = xi.spells.enfeebling.calculatePotency(caster, target, spellId, skillType, statUsed)
            potency        = math.floor(potency * resistPotency)
        end

        -- Set tick (Poison, etc...)
        local tick = pTable[spellId][6]

        -- Final operations.
        if target:addStatusEffect(spellEffect, potency, tick, duration) then
            -- Add "Magic Burst!" message
            local _, skillchainCount = FormMagicBurst(spellElement, target) -- External function. Not present in magic.lua.

            if skillchainCount > 0 then
                spell:setMsg(spell:getMagicBurstMessage())
                caster:triggerRoeEvent(xi.roe.triggers.magicBurst)
            else
                spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            end
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return spellEffect
end
