-----------------------------------
-- Spell: Heavy Strike
-- Delivers a blunt attack
-- Spell cost: 41 MP
-- Monster Type: Dragon
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 4
-- Stat Bonus: STR+3, VIT+3
-- Level: 92
-- Casting Time: 0.5 seconds
-- Recast Time: 21 seconds
-----------------------------------
-- Combos: Double Attack, Triple Attack
-----------------------------------
-- Notes: PROXY FORMULA: Based on Empty Thrash (WSC 50% STR, fTP 2.0)
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- PROXY: Using Empty Thrash formula
    local params = {}
    params.ecosystem = xi.ecosystem.DRAGON
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.HTH
    params.numhits = 1
    params.multiplier = 2.0
    params.tp150 = 2.0
    params.tp300 = 2.0
    params.azuretp = 2.0
    params.duppercap = 93
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
