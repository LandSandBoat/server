-----------------------------------------
-- Spell: Poison Breath
-- Deals water damage to enemies within a fan-shaped area originating from the caster. Additional effect: Poison
-- Spell cost: 22 MP
-- Monster Type: Hound
-- Spell Type: Magical (Water)
-- Blue Magic Points: 1
-- Stat Bonus: MND+1
-- Level: 22
-- Casting Time: 3 seconds
-- Recast Time: 19.5 seconds
-- Magic Bursts on: Reverberation, Distortion, and Darkness
-- Combos: Clear Mind
-- Damage formula is (Current HP)/10 + (Blue Mage level)/1.25
-- Gains a 25% damage boost when used against Arcana monsters.
-- Poison effect is 4/tick
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
    params.attackType = tpz.attackType.BREATH
    params.damageType = tpz.damageType.WATER
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 1.0
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.multiplier = multi
    params.tMultiplier = 1.5
    params.duppercap = 69
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.3
    params.chr_wsc = 0.0
    local resist = applyResistance(caster, target, spell, params)
    local multi = 1.08
    local HP = caster:getHP()
    local LVL = caster:getMainLvl()
    local damage = (HP / 10) + (LVL / 1.25)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    if (caster:hasStatusEffect(tpz.effect.AZURE_LORE)) then
        multi = multi + 0.50
    end

    if (damage > 0 and resist > 0.3) then
        local typeEffect = tpz.effect.POISON
        target:delStatusEffect(typeEffect)
        target:addStatusEffect(typeEffect, 4, 0, getBlueEffectDuration(caster, resist, typeEffect))
    end

    return damage
end
