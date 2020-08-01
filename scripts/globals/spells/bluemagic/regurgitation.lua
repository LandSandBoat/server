-----------------------------------------
-- Spell: Regurgitation
-- Deals Water damage to an enemy. Additional Effect: Bind
-- Spell cost: 69 MP
-- Monster Type: Lizards
-- Spell Type: Magical (Water)
-- Blue Magic Points: 1
-- Stat Bonus: INT+1 MND+1 MP+3
-- Level: 68
-- Casting Time: 5 seconds
-- Recast Time: 24 seconds
-- Magic Bursts on: Reverberation, Distortion, and Darkness
-- Combos: Resist Gravity
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    params.attackType = tpz.attackType.MAGICAL
    params.damageType = tpz.damageType.WATER
    params.multiplier = 1.83
    params.tMultiplier = 2.0
    params.duppercap = 69
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.30
    params.chr_wsc = 0.0
    damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    if (caster:isBehind(target, 15)) then -- guesstimating the angle at 15 degrees here
        damage = math.floor(damage * 1.25)
        -- printf("is behind mob")
    end
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    --TODO: Knockback? Where does that get handled? How much knockback does it have?
    local params = {}
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 1.0
    local resist = applyResistance(caster, target, spell, params)

    if (damage > 0 and resist > 0.125) then
        local typeEffect = tpz.effect.BIND
        target:delStatusEffect(typeEffect)
        target:addStatusEffect(typeEffect, 1, 0, getBlueEffectDuration(caster, resist, typeEffect))
    end

    return damage
end
