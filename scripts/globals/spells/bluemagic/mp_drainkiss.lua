-----------------------------------------
-- Spell: MP Drainkiss
-- Steals an enemy's MP. Ineffective against undead
-- Spell cost: 20 MP
-- Monster Type: Amorphs
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 4
-- Stat Bonus: MP+5
-- Level: 42
-- Casting Time: 4 seconds
-- Recast Time: 90 seconds
-- Magic Bursts on: Compression, Gravitation, Darkness
-- Combos: None
-- Notes:
-- Affected by Blue Magic Skill and Magic Accuracy.
-- Soft cap at 165MP before Magic Bursts / Day and Weather/Elemental Affinity effects.
-- Elemental Affinity and Elemental Obis affect both accuracy and amount of MP drained.
-- Magic Burst affects both accuracy and amount of MP drained.
-- INT increases Magic Accuracy in general, but is not a modifier of this spell.
-- Unlike Magic Hammer, MP drained is not enhanced by Magic Attack Bonus.
-- A positive Monster Correlation (vs Birds) or a negative Monster Correlation (vs Aquans), affects both accuracy and potency.
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    -- also have small constant to account for 0 dark skill
    local dmg = utils.clamp(5 + 0.375 * caster:getSkillLevel(tpz.skill.BLUE_MAGIC), 0, 165)
    -- get resist multiplier (1x if no resist)
    local params = {}
    params.diff = caster:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 1.0
    local resist = applyResistance(caster, target, spell, params)
    -- get the resisted damage
    dmg = dmg*resist
    -- add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = addBonuses(caster, spell, target, dmg)
    -- add in target adjustment
    dmg = adjustForTarget(target, dmg, spell:getElement())
    -- add in final adjustments

    if (dmg < 0) then
        dmg = 0
    end

    dmg = dmg * BLUE_POWER

    if (target:isUndead()) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- No effect
        return dmg
    end

    if (target:getMP() > dmg) then
        caster:addMP(dmg)
        target:delMP(dmg)
    else
        dmg = target:getMP()
        caster:addMP(dmg)
        target:delMP(dmg)
    end

    return dmg
end
