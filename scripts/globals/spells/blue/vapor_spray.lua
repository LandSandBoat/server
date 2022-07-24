-----------------------------------
-- NEEDS VALIDATION AND MORE INFORMATION
-- Spell: Vapor Spray
-- Deals water breath damage to enemies within a fan-shaped area originating from the caster.
-- Spell cost: 172 MP
-- Monster Type: Luminians
-- Spell Type: Magical (Water)
-- Blue Magic Points: 3
-- Stat Bonus: HP+15 VIT+4
-- Level: 96
-- Casting Time: 3 seconds
-- Recast Time: 56 seconds
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
    local multi = 6.38 -- needs validation
    if (caster:hasStatusEffect(xi.effect.AZURE_LORE)) then
        multi = multi + 0.50
    end

    local params = {}
    params.diff = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.bonus = 1.0
    local resist = applyResistance(caster, target, spell, params)
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.attackType = xi.attackType.BREATH
    params.damageType = xi.damageType.WATER
    params.multiplier = multi
    params.tMultiplier = 1.5
    params.duppercap = 99
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.3
    params.chr_wsc = 0.0
    local damage = BlueMagicalSpell(caster, target, spell, params, MND_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    if (damage > 0 and resist > 0.3) then
        local typeEffect = xi.effect.PARALYSIS
        target:delStatusEffect(typeEffect)
        target:addStatusEffect(typeEffect, 25, 0, getBlueEffectDuration(caster, resist, typeEffect))
    end

    return damage
end

return spell_object
