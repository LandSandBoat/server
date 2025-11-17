-----------------------------------
-- Spell: Empty Thrash
-- Deals physical damage to enemies within a fan-shaped area
-- Spell cost: 33 MP
-- Monster Type: Undead
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: STR+3, CHR-2
-- Level: 87
-- Casting Time: 0.5 seconds
-- Recast Time: 21 seconds
-- Combos: Double Attack, Triple Attack
-----------------------------------
-- Research from BG-Wiki:
-- - Number of Hits: 1
-- - WSC: 50% STR
-- - fTP: 2.0 (Static)
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.UNDEAD
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.HTH
    params.numhits = 1
    params.multiplier = 2.0
    params.tp150 = 2.0  -- Static fTP
    params.tp300 = 2.0
    params.azuretp = 2.0
    params.duppercap = 88  -- Level 87 spell
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
