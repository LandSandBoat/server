-----------------------------------
-- Spell: Foul Waters
-- Deals water damage to enemies in a fan-shaped area originating from caster. Additional Effect: Drown
-- Spell cost: 76 MP
-- Monster Type: Amorphs
-- Spell Type: Magical (Water)
-- Level: 99
-- Casting Time: 3.5 seconds
-- Recast Time: 60 seconds
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
    params.multiplier = 2.25
    params.tMultiplier = 2.0
    params.duppercap = 99 -- unknown
    params.str_wsc = 0.2
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.2
    params.chr_wsc = 0.0
    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    local resist = applyResistance(caster, target, spell, {
        attribute = xi.mod.INT,
        skillType = xi.skill.BLUE_MAGIC,
        effect = xi.effect.DROWN
    })
    if (resist > 0.0625) then
        if (target:canGainStatusEffect(xi.effect.DROWN)) then
            target:addStatusEffect(xi.effect.DROWN, 31, 0, 180 * resist)
        end
    end

    return damage
end

return spell_object
