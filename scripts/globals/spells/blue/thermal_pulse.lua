-----------------------------------
-- Spell: Thermal Pulse
-- Deals Fire damage to enemies within area of effect. Additional effect: Blindness
-- Spell cost: 151 MP
-- Monster Type: Vermin
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 3
-- Stat Bonus: VIT +2
-- Level: 86
-- Casting Time: 5.5 seconds
-- Recast Time: 70 seconds
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
    params.damageType = xi.damageType.FIRE
    params.multiplier = 2.75
    params.tMultiplier = 2.0
    params.duppercap = 99 -- unknown
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.4
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    local resist = applyResistance(caster, target, spell, {
        attribute = xi.mod.INT,
        skillType = xi.skill.BLUE_MAGIC,
        effect = xi.effect.BLINDNESS
    })
    if (resist > 0.0625) then
        if (target:canGainStatusEffect(xi.effect.BLINDNESS)) then
            target:addStatusEffect(xi.effect.BLINDNESS, 10, 3, 120)
        end
    end

    return damage
end

return spell_object
