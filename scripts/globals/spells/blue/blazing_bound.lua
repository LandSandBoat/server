-----------------------------------
-- Spell: Blazing Bound
-- Deals fire damage to an enemy
-- Spell cost: 113 MP
-- Monster Type: Vorageans
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+2 AGI+1
-- Level: 80
-- Casting Time: 6 seconds
-- Recast Time: 30 seconds
-- Combos: None
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
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.FIRE
    params.multiplier = 3.0
    params.tMultiplier = 2.0
    params.duppercap = 97 -- unknown
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
