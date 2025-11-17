-----------------------------------
-- Spell: Thrashing Assault
-- Delivers a fourfold attack
-- Spell cost: 75 MP
-- Monster Type: Aquan
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 7
-- Stat Bonus: STR+5
-- Level: 99
-- Casting Time: 0.5 seconds
-- Recast Time: 30 seconds
-----------------------------------
-- Combos: Double Attack
-----------------------------------
-- Notes: PROXY FORMULA: Based on Amorphic Spikes (WSC 20% DEX/20% INT, fTP 1.0)
-- 4 hits assumed, adjusted to 50% STR given the STR+5 stat bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- PROXY: Using Amorphic Spikes formula (4 hits, STR-based)
    local params = {}
    params.ecosystem = xi.ecosystem.AQUAN
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.HTH
    params.numhits = 4
    params.multiplier = 1.0
    params.tp150 = 1.0
    params.tp300 = 1.0
    params.azuretp = 1.0
    params.duppercap = 99
    params.str_wsc = 0.5
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
