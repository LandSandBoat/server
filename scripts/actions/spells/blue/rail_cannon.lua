-----------------------------------
-- Spell: Rail Cannon
-- Delivers a physical attack
-- Spell cost: 80 MP
-- Monster Type: Arcana
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 5
-- Stat Bonus: STR+6
-- Level: 99
-- Casting Time: 3 seconds
-- Recast Time: 30 seconds
-----------------------------------
-- Combos: None
-----------------------------------
-- Notes: PROXY FORMULA: Based on Barbed Crescent (WSC 50% DEX, fTP 2.0)
-- Adjusted to 50% STR given the STR+6 stat bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- PROXY: Using Barbed Crescent formula, adjusted to STR-based
    local params = {}
    params.ecosystem = xi.ecosystem.ARCANA
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.HTH
    params.numhits = 1
    params.multiplier = 2.0
    params.tp150 = 2.0
    params.tp300 = 2.0
    params.azuretp = 2.0
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
