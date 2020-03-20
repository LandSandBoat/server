-----------------------------------------
-- Spell: Dia III
-- Lowers an enemy's defense and gradually deals light elemental damage.
-- caster:getMerit() returns a value which is equal to the number of merit points TIMES the value of each point
-- Dia III value per point is '30' This is a constant set in the table 'merits'
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
    local basedmg = caster:getSkillLevel(tpz.skill.ENFEEBLING_MAGIC) / 4
    local params = {}
    params.dmg = basedmg
    params.multiplier = 5
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.attribute = tpz.mod.INT
    params.hasMultipleTargetReduction = false
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 1.0

    -- Calculate raw damage
    local dmg = calculateMagicDamage(caster, target, spell, params)
    -- Softcaps at 32, should always do at least 1
    dmg = utils.clamp(dmg, 1, 32)
    -- Get resist multiplier (1x if no resist)
    local resist = applyResistance(caster, target, spell, params)
    -- Get the resisted damage
    dmg = dmg * resist
    -- Add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = addBonuses(caster, spell, target, dmg)
    -- Add in target adjustment
    dmg = adjustForTarget(target, dmg, spell:getElement())
    -- Add in final adjustments including the actual damage dealt
    local final = finalMagicAdjustments(caster, target, spell, dmg)

    -- Calculate duration and bonus
    local duration = calculateDuration(caster:getMerit(tpz.merit.DIA_III), spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local dotBonus = caster:getMod(tpz.mod.DIA_DOT) -- Dia Wand
    -- If caster has the spell but no merits in it, they are either a mob or we assume they are GM or otherwise gifted with max duration
    if duration == 0 then
        duration = 150
    end

    -- Check for Bio
    local bio = target:getStatusEffect(tpz.effect.BIO)

    -- Do it!
    target:addStatusEffect(tpz.effect.DIA, 3 + dotBonus, 3, duration, 0, 20, 3)
    spell:setMsg(tpz.msg.basic.MAGIC_DMG)

    -- Try to kill same tier Bio (non-default behavior)
    if BIO_OVERWRITE == 1 and bio ~= nil then
        if bio:getPower() <= 3 then
            target:delStatusEffect(tpz.effect.BIO)
        end
    end

    return final
end
