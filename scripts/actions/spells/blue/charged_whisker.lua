-----------------------------------
-- Spell: Charged Whisker
-- Deals lightning damage to enemies within area of effect
-- Spell cost: 183 MP
-- Monster Type: Beast
-- Spell Type: Magical (Lightning)
-- Blue Magic Points: 4
-- Stat Bonus: HP-10, DEX+2, INT+2
-- Level: 88
-- Casting Time: 7 seconds
-- Recast Time: 60 seconds
-- Magic Bursts on: Impaction, Fragmentation, Light
-- Combos: Gilfinder, Treasure Hunter
-----------------------------------
-- Research from BG-Wiki:
-- - WSC: 50% DEX
-- - fTP: 4.5
-- - dINT Multiplier: 2.0
-- - AoE: Caster-centered, radial 12.5' yalms
-- - Strongly affected by MAB, Day/Weather, and Obis
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem   = xi.ecosystem.BEAST
    params.attackType  = xi.attackType.MAGICAL
    params.damageType  = xi.damageType.LIGHTNING
    params.attribute   = xi.mod.INT
    params.multiplier  = 4.5
    params.tMultiplier = 2.0
    params.duppercap   = 89  -- Level 88 spell
    params.str_wsc     = 0.0
    params.dex_wsc     = 0.5
    params.vit_wsc     = 0.0
    params.agi_wsc     = 0.0
    params.int_wsc     = 0.0
    params.mnd_wsc     = 0.0
    params.chr_wsc     = 0.0

    local damage = xi.spells.blue.useMagicalSpell(caster, target, spell, params)

    return damage
end

return spellObject
