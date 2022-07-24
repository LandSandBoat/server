-----------------------------------
-- Spell: Embalming Earth
-- Deals Earth damage to enemies within range. Additional effect: Slow
-- Spell cost: 57 MP
-- Monster Type: Lizards
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 6
-- Stat Bonus: STR+6
-- Level: 99
-- Casting Time: 4.5 seconds
-- Recast Time: 24 seconds
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
    params.damageType = xi.damageType.EARTH
    params.multiplier = 3.0
    params.tMultiplier = 2.0
    params.duppercap = 99 -- unknown
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.3
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    local resist = applyResistance(caster, target, spell, {
        attribute = xi.mod.INT,
        skillType = xi.skill.BLUE_MAGIC,
        effect = xi.effect.SLOW
    })
    if (resist > 0.0625) then
        if (target:canGainStatusEffect(xi.effect.SLOW)) then
            target:addStatusEffect(xi.effect.SLOW, 25, 3, 180 * resist)
        end
    end

    return damage
end

return spell_object
