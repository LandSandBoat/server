-----------------------------------
-- Spell: Leafstorm
-- Deals wind damage within area of effect.
-- Spell cost: 132 MP
-- Monster Type: Plantoids
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 4
-- Stat Bonus: MP+3 MND+1 CHR+1
-- Level: 77
-- Casting Time: 7 seconds
-- Recast Time: 62 seconds
-- Combos: Conserve MP
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local params = {}
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.WATER
    params.multiplier = 2.75
    params.tMultiplier = 2.0
    params.duppercap = 94 -- unknown
    params.str_wsc = 0.3
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end

return spell_object
