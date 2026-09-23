-----------------------------------
-- Module: Enhancing Spell Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('enhancing_spell_adjustments')

local column =
{
    EFFECT_LEVEL     = 3,
    EFFECT_POWER     = 4,
    EFFECT_COMPOSURE = 6,
}

-- Protect / Shell: Revert power caps.
-- Source: https://forum.square-enix.com/ffxi/threads/55360-May.-10-2019-%28JST%29-Version-Update?p=615387&viewfull=1#post615387
local eraBasePower =
{
    [xi.magic.spell.PROTECT      ] =   10,
    [xi.magic.spell.PROTECT_II   ] =   25,
    [xi.magic.spell.PROTECT_III  ] =   40,
    [xi.magic.spell.PROTECT_IV   ] =   55,
    [xi.magic.spell.PROTECT_V    ] =   60,
    [xi.magic.spell.PROTECTRA    ] =   10,
    [xi.magic.spell.PROTECTRA_II ] =   25,
    [xi.magic.spell.PROTECTRA_III] =   40,
    [xi.magic.spell.PROTECTRA_IV ] =   55,
    [xi.magic.spell.PROTECTRA_V  ] =   60,
    [xi.magic.spell.SHELL        ] =  937,
    [xi.magic.spell.SHELL_II     ] = 1406,
    [xi.magic.spell.SHELL_III    ] = 1875,
    [xi.magic.spell.SHELL_IV     ] = 2187,
    [xi.magic.spell.SHELL_V      ] = 2421,
    [xi.magic.spell.SHELLRA      ] =  937,
    [xi.magic.spell.SHELLRA_II   ] = 1406,
    [xi.magic.spell.SHELLRA_III  ] = 1875,
    [xi.magic.spell.SHELLRA_IV   ] = 2187,
    [xi.magic.spell.SHELLRA_V    ] = 2421,
}

for spellId, basePower in pairs(eraBasePower) do
    xi.spells.enhancing.spellPTable[spellId][column.EFFECT_POWER] = basePower
end

-- Deodorize / Sneak / Invisible: Revert base duration to a random 30s-300s.
-- Capture needed
-- TODO: Everything past the base duration mirrors core.
m:addOverride('xi.spells.enhancing.calculateEnhancingDuration', function(caster, target, spell, spellId, spellGroup, spellEffect)
    if
        spellEffect ~= xi.effect.DEODORIZE and
        spellEffect ~= xi.effect.INVISIBLE and
        spellEffect ~= xi.effect.SNEAK
    then
        return super(caster, target, spell, spellId, spellGroup, spellEffect)
    end

    local spellRow     = xi.spells.enhancing.spellPTable[spellId]
    local spellLevel   = spellRow[column.EFFECT_LEVEL]
    local useComposure = spellRow[column.EFFECT_COMPOSURE]
    local targetLevel  = target:getMainLvl()

    -- Reverted base duration.
    local duration = math.randomInt(30, 300)

    -- Gear durations (e.g. Skulker's Cape).
    if spellEffect == xi.effect.INVISIBLE then
        duration = duration + target:getMod(xi.mod.INVISIBLE_DURATION)
    elseif spellEffect == xi.effect.SNEAK then
        duration = duration + target:getMod(xi.mod.SNEAK_DURATION)
    end

    -- Composure.
    if
        useComposure and
        caster:hasStatusEffect(xi.effect.COMPOSURE) and
        caster:getID() == target:getID()
    then
        duration = duration * 3
    end

    -- Level penalty to duration.
    if targetLevel < spellLevel then
        duration = duration * targetLevel / spellLevel
    end

    return duration
end)

-----------------------------------
-- Merits: Protectra V / Shellra V (power), Phalanx II (power and duration).
-- Source: https://forum.square-enix.com/ffxi/threads/55360-May.-10-2019-%28JST%29-Version-Update?p=615387&viewfull=1#post615387
-- Source: https://forum.square-enix.com/ffxi/threads/55751-August.-6-2019-%28JST%29-Version-Update
-----------------------------------

-- ranksInBase: merit ranks the value out of core already carries. Protectra V and
-- Shellra V are reverted above; Phalanx II keeps its 2019 base (skill / 25 + 16 and
-- 240s), which is the five rank value.
local meritBonusBySpell =
{
    [xi.magic.spell.PROTECTRA_V] = { merit = xi.merit.PROTECTRA_V, valuePerRank = 5, ranksInBase = 1, power = 2  },
    [xi.magic.spell.SHELLRA_V  ] = { merit = xi.merit.SHELLRA_V,   valuePerRank = 2, ranksInBase = 1, power = 78 },
    [xi.magic.spell.PHALANX_II ] = { merit = xi.merit.PHALANX_II,  valuePerRank = 3, ranksInBase = 5, power = 3, duration = 30 },
}

m:addOverride('xi.spells.enhancing.calculateEnhancingFinalPower', function(caster, target, spell, basePower, spellGroup, tier, spellEffect)
    local finalPower = super(caster, target, spell, basePower, spellGroup, tier, spellEffect)
    local entry      = meritBonusBySpell[spell:getID()]

    if entry then
        local meritRank = math.max(caster:getMerit(entry.merit) / entry.valuePerRank, 1)
        finalPower = finalPower + (meritRank - entry.ranksInBase) * entry.power
    end

    return finalPower
end)

m:addOverride('xi.spells.enhancing.calculateEnhancingDuration', function(caster, target, spell, spellId, spellGroup, spellEffect)
    local duration = super(caster, target, spell, spellId, spellGroup, spellEffect)
    local entry    = meritBonusBySpell[spellId]

    if entry and entry.duration then
        local meritRank = math.max(caster:getMerit(entry.merit) / entry.valuePerRank, 1)
        duration = duration + (meritRank - entry.ranksInBase) * entry.duration
    end

    return duration
end)

return m
