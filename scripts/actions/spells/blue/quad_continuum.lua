-----------------------------------
-- Spell: Quad Continuum
-- Delivers a fourfold attack
-- Spell cost: 55 MP
-- Monster Type: Luminian
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 4
-- Stat Bonus: DEX+4, AGI+4
-- Level: 85
-- Casting Time: 0.5 seconds
-- Recast Time: 25 seconds
-----------------------------------
-- Combos: Dual Wield
-----------------------------------
-- Notes: PROXY FORMULA: Based on Amorphic Spikes (WSC 20% DEX/20% INT, fTP 1.0)
-- 4 hits instead of 5
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- PROXY: Using Amorphic Spikes formula (4 hits)
    local params = {}
    params.ecosystem = xi.ecosystem.LUMINIAN
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.PIERCING
    params.numhits = 4
    params.multiplier = 1.0
    params.tp150 = 1.0
    params.tp300 = 1.0
    params.azuretp = 1.0
    params.duppercap = 86
    params.str_wsc = 0.0
    params.dex_wsc = 0.2
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.2
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
