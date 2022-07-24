-----------------------------------
-- Spell: Droning Whirlwind
-- Additional effect: Dispel
-- Spell cost: 224 MP
-- Monster Type: Vermin
-- Spell Type: Magical (Wind)
-- Level: 99
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/magic")
require("scripts/globals/status")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local multi = 4.0
    if (caster:hasStatusEffect(xi.effect.AZURE_LORE)) then
        multi = multi + 1.50
    end
    local params = {}
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.WATER
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.effect = xi.effect.NONE
    params.multiplier = multi
    params.tMultiplier = 2.0
    params.duppercap = 100
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    -- Assumed unresistable and removes all status effects
    target:dispelAllStatusEffects()

    return damage
end

return spell_object
