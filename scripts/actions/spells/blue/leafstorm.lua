-----------------------------------
-- Spell: Leafstorm
-- Deals wind damage to enemies within area of effect
-- Spell cost: 132 MP
-- Monster Type: Plantoid
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 4
-- Stat Bonus: AGI+2, INT+2
-- Level: 77
-- Casting Time: 5 seconds
-- Recast Time: 45 seconds
-----------------------------------
-- Combos: Magic Burst Bonus
-----------------------------------
-- Notes: PROXY FORMULA: Based on Charged Whisker (WSC 50% DEX, fTP 4.5, dINT 2.0)
-- Adjusted to INT-based given the INT+2 stat bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- PROXY: Using Charged Whisker formula (AoE caster-centered), adjusted to INT
    local params = {}
    params.ecosystem   = xi.ecosystem.PLANTOID
    params.attackType  = xi.attackType.MAGICAL
    params.damageType  = xi.damageType.WIND
    params.attribute   = xi.mod.INT
    params.multiplier  = 4.5
    params.tMultiplier = 2.0
    params.duppercap   = 78
    params.str_wsc     = 0.0
    params.dex_wsc     = 0.0
    params.vit_wsc     = 0.0
    params.agi_wsc     = 0.0
    params.int_wsc     = 0.5
    params.mnd_wsc     = 0.0
    params.chr_wsc     = 0.0

    local damage = xi.spells.blue.useMagicalSpell(caster, target, spell, params)

    return damage
end

return spellObject
