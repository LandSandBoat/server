-----------------------------------------
-- Spell: Blastbomb
-- Deals fire damage to enemies within area of effect. Additional effect: "Bind"
-- Spell cost: 36 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 2
-- Stat Bonus: STR+1
-- Level: 18
-- Casting Time: 2.25 seconds
-- Recast Time: 15 seconds
-- Magic Bursts on: Liquefaction, Fusion, Light
-- Combos: None
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
    params.damageType = tpz.damageType.FIRE
    params.multiplier = 1.375
    params.tMultiplier = 1.0
    params.duppercap = 30
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.2
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    local params = {}
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 1.0
    local resist = applyResistance(caster, target, spell, params)

    if (damage > 0 and resist > 0.125) then
        local typeEffect = tpz.effect.BIND
        target:delStatusEffect(typeEffect) -- Wiki says it can overwrite itself or other binds
        target:addStatusEffect(typeEffect, 1, 0, getBlueEffectDuration(caster, resist, typeEffect))
    end

    return damage
end
