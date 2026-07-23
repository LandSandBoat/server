-----------------------------------
-- Module: Enfeebling Spell Adjustments
-- Source: https://forum.square-enix.com/ffxi/threads/46531-Mar-26-2015-%28JST%29-Version-Update
-- TODO: Convert to new spell organization once upstream is reworked
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('enfeebling_spell_adjustments', xi.pre(xi.expansion.SOA))

-- Poison / Poisonga / Poison II: Revert potency formula to pre-2015 values.
-- Source: https://wiki.ffo.jp/html/833.html
-- Source: https://forum.square-enix.com/ffxi/threads/46531-Mar-26-2015-%28JST%29-Version-Update
local poisonPotency =
{
    [xi.magic.spell.POISON   ] =
    {
        { maxSkill = 79,  potency = 1 },
        { maxSkill = 159, potency = 2 },
        { maxSkill = 239, potency = 3 },
        { maxSkill = 999, potency = 4 },
    },

    [xi.magic.spell.POISONGA ] =
    {
        { maxSkill = 79,  potency = 1 },
        { maxSkill = 159, potency = 2 },
        { maxSkill = 239, potency = 3 },
        { maxSkill = 999, potency = 4 },
    },

    [xi.magic.spell.POISON_II] =
    {
        { maxSkill = 124, potency = 4  },
        { maxSkill = 149, potency = 5  },
        { maxSkill = 174, potency = 6  },
        { maxSkill = 199, potency = 7  },
        { maxSkill = 224, potency = 8  },
        { maxSkill = 249, potency = 9  },
        { maxSkill = 999, potency = 10 },
    },
}

-- Blind / Blind II: Revert post-2015 potency formula.
-- Poison / Poison II / Poisonga: Revert post-2015 potency formula
-- Source: https://forum.square-enix.com/ffxi/threads/46531-Mar-26-2015-%28JST%29-Version-Update
m:addOverride('xi.spells.enfeebling.calculatePotency', function(caster, target, spellId, spellEffect, skillType, statUsed)
    local potency

    if
        spellId == xi.magic.spell.BLIND or
        spellId == xi.magic.spell.BLIND_II
    then
        local statDiff = caster:getStat(statUsed) - target:getStat(xi.mod.MND)
        local offset   = spellId == xi.magic.spell.BLIND_II and 100 or 60
        potency = math.max(math.floor((statDiff + offset) / 4), 0)

    elseif poisonPotency[spellId] then
        local skillLevel = caster:getSkillLevel(skillType)

        for _, entry in ipairs(poisonPotency[spellId]) do
            if skillLevel <= entry.maxSkill then
                potency = entry.potency
                break
            end
        end

    else
        return super(caster, target, spellId, spellEffect, skillType, statUsed)
    end

    if
        caster:hasStatusEffect(xi.effect.SABOTEUR) and
        skillType == xi.skill.ENFEEBLING_MAGIC
    then
        if target:isNM() then
            potency = math.floor(potency * (1.3 + caster:getMod(xi.mod.ENHANCES_SABOTEUR)))
        else
            potency = math.floor(potency * (2 + caster:getMod(xi.mod.ENHANCES_SABOTEUR)))
        end
    end

    -- General Enfeebling potency modifier.
    return math.floor(potency * (1 + caster:getMod(xi.mod.ENF_MAG_POTENCY) / 100))
end)

-- Blind / Blind II: Revert fixed 180s duration to variable duration.
-- Paralyze / Paralyze II / Silence: Revert fixed 120s duration to variable duration.
-- Poison / Poisonga: Revert base duration to 30s.
m:addOverride('xi.spells.enfeebling.calculateDuration', function(caster, target, spellId, spellEffect, skillType)
    local duration = 0

    if
        spellId == xi.magic.spell.BLIND or
        spellId == xi.magic.spell.BLIND_II
    then
        duration = math.randomInt(80, 300)
    elseif
        spellId == xi.magic.spell.PARALYZE or
        spellId == xi.magic.spell.PARALYZE_II
    then
        duration = math.randomInt(30, 120)
    elseif spellId == xi.magic.spell.SILENCE then
        -- Retail rolled 0-120s, but a duration of 0 never expires and a half resist halves this.
        duration = math.randomInt(2, 120)
    elseif
        spellId == xi.magic.spell.POISON or
        spellId == xi.magic.spell.POISONGA
    then
        duration = 30
    else
        return super(caster, target, spellId, spellEffect, skillType)
    end

    if skillType == xi.skill.ENFEEBLING_MAGIC then
        if caster:hasStatusEffect(xi.effect.SABOTEUR) then
            if target:isNM() then
                duration = duration * 1.25
            else
                duration = duration * 2
            end
        end

        if caster:getMainJob() == xi.job.RDM then
            duration = duration + caster:getMerit(xi.merit.ENFEEBLING_MAGIC_DURATION)
            duration = duration + caster:getJobPointLevel(xi.jp.ENFEEBLE_DURATION)

            if caster:hasStatusEffect(xi.effect.STYMIE) then
                duration = duration + caster:getJobPointLevel(xi.jp.STYMIE_EFFECT)
            end
        end

        duration = math.floor(duration * (1 + caster:getMod(xi.mod.ENF_MAG_DURATION) / 100))
    end

    return math.floor(duration)
end)

-----------------------------------
-- Merits: Slow II / Paralyze II / Blind II potency and magic accuracy.
-- Source: https://forum.square-enix.com/ffxi/threads/55751-August.-6-2019-%28JST%29-Version-Update
-----------------------------------
local merits = Module:new('enfeebling_merit_adjustments', xi.pre(xi.expansion.ROV))

-- Merit value is 1, so getMerit is the rank count; rank one only unlocks the spell.
-- ranksInBase: ranks core's potency already carries - five for the 2019 formulas, one for Blind II, reverted above to its pre-2015 formula.
local meritBySpell =
{
    [xi.magic.spell.SLOW_II    ] = { merit = xi.merit.SLOW_II,     potency = 100, ranksInBase = 5, magicAccuracy = 2 },
    [xi.magic.spell.PARALYZE_II] = { merit = xi.merit.PARALYZE_II, potency = 1,   ranksInBase = 5, magicAccuracy = 2 },
    [xi.magic.spell.BLIND_II   ] = { merit = xi.merit.BLIND_II,    potency = 1,   ranksInBase = 1, magicAccuracy = 2 },
}

merits:addOverride('xi.spells.enfeebling.calculatePotency', function(caster, target, spellId, spellEffect, skillType, statUsed)
    local potency = super(caster, target, spellId, spellEffect, skillType, statUsed)
    local entry   = meritBySpell[spellId]

    if entry then
        local meritRank = math.max(caster:getMerit(entry.merit), 1)
        potency = potency + (meritRank - entry.ranksInBase) * entry.potency
    end

    return potency
end)

-- Apply magic accuracy merit mod for spell calculations and remove it afterward.
merits:addOverride('xi.spells.enfeebling.useEnfeeblingSpell', function(caster, target, spell)
    local entry     = meritBySpell[spell:getID()]
    local meritRank = entry and caster:getMerit(entry.merit) or 0

    if meritRank < 2 then
        return super(caster, target, spell)
    end

    local maccBonus = (meritRank - 1) * entry.magicAccuracy

    caster:addMod(xi.mod.MACC, maccBonus)

    local castOk, spellEffect = pcall(super, caster, target, spell)

    caster:delMod(xi.mod.MACC, maccBonus)

    if not castOk then
        error(spellEffect, 0)
    end

    return spellEffect
end)

return m
