-----------------------------------------
-- Spell: Bio III
-- Deals dark damage that weakens an enemy's attacks and gradually reduces its HP.
-- caster:getMerit() returns a value which is equal to the number of merit points TIMES the value of each point
-- Bio III value per point is '30' This is a constant set in the table 'merits'
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")
--------------------------------------

function onMagicCastingCheck(caster,target,spell)
    return 0
end

function onSpellCast(caster,target,spell)
    local basedmg = caster:getSkillLevel(tpz.skill.DARK_MAGIC) / 4
    local params = {}
    params.dmg = basedmg
    params.multiplier = 3
    params.skillType = tpz.skill.DARK_MAGIC
    params.attribute = tpz.mod.INT
    params.hasMultipleTargetReduction = false
    params.diff = caster:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.DARK_MAGIC
    params.bonus = 1.0

    -- Calculate raw damage
    local dmg = calculateMagicDamage(caster, target, spell, params)
    -- Softcaps at 62, should always do at least 1
    dmg = utils.clamp(dmg, 1, 62)
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

    -- Calculate duration
    local duration = caster:getMerit(tpz.merit.BIO_III)
    -- If caster has the spell but no merits in it, they are either a mob or we assume they are GM or otherwise gifted with max duration
    if duration == 0 then
        duration = 150
    end

    -- Check for Dia
    local dia = target:getStatusEffect(tpz.effect.DIA)

    -- Calculate DoT effect (rough, though fairly accurate)
    local dotdmg = 4 + math.floor(caster:getSkillLevel(tpz.skill.DARK_MAGIC) / 60)

    -- Do it!
    target:addStatusEffect(tpz.effect.BIO, dotdmg, 3, duration, 0, 20, 3)
    spell:setMsg(tpz.msg.basic.MAGIC_DMG)

    -- Try to kill same tier Dia (default behavior)
    if DIA_OVERWRITE == 1 and dia ~= nil then
        if dia:getPower() <= 3 then
            target:delStatusEffect(tpz.effect.DIA)
        end
    end

    return final
end
