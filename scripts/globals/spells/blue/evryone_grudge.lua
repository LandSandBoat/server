-----------------------------------
-- Spell: Evryone. Grudge
-- Deals dark damage to an enemy.
-- Spell cost: 185 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 4
-- Stat Bonus: INT+2 MND+2 STR-1 VIT-1
-- Level: 90
-- Casting Time: 5.5 seconds
-- Recast Time: 270 seconds
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
    params.damageType = xi.damageType.DARK
    params.multiplier = 5.0
    params.tMultiplier = 2.0
    params.duppercap = 99
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.4
    params.chr_wsc = 0.0
    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end

return spell_object
