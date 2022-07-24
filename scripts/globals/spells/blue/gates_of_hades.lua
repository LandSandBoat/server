-----------------------------------
-- Spell: Gates of Hades
-- Deals fire damage to enemies within area of effect. Additional effect: Burn
-- Spell cost: 156 MP
-- Monster Type: Beasts
-- Spell Type: Magical (Fire)
-- Level: 97
-- Casting Time: 3.5 seconds
-- Recast Time: 30 seconds
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
    params.multiplier = 5.0
    params.tMultiplier = 1.0
    params.duppercap = 9 -- unknown
    params.str_wsc = 0.2
    params.dex_wsc = 0.2
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    local resist = applyResistance(caster, target, spell, {
        attribute = xi.mod.INT,
        skillType = xi.skill.BLUE_MAGIC,
        effect = xi.effect.BURN
    })
    if (resist > 0.0625) then
        if (target:canGainStatusEffect(xi.effect.MAGIC_DEF_DOWN)) then
            target:addStatusEffect(xi.effect.BURN, 22, 0, 90)
        end
    end

    return damage
end

return spell_object