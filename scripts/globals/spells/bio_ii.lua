-----------------------------------------
-- Spell: Bio II
-- Deals dark damage that weakens an enemy's attacks and gradually reduces its HP.
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
    local skillLvl = caster:getSkillLevel(tpz.skill.DARK_MAGIC)
    local basedmg = skillLvl / 4
    local params = {}
    params.dmg = basedmg
    params.multiplier = 2
    params.skillType = tpz.skill.DARK_MAGIC
    params.attribute = tpz.mod.INT
    params.hasMultipleTargetReduction = false
    params.diff = caster:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.DARK_MAGIC
    params.bonus = 1.0

    -- Calculate raw damage
    local dmg = calculateMagicDamage(caster, target, spell, params)
    -- Softcaps at 30, should always do at least 1
    dmg = utils.clamp(dmg, 1, 30)
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
    local duration = 120

    -- Check for Dia
    local dia = target:getStatusEffect(tpz.effect.DIA)

    -- Calculate DoT effect. Unknown formula, but known cap of 8 and some known breakpoints.
    local dotdmg = 0
    if skillLvl > 290 then
        dotdmg = 8
    elseif skillLvl > 268 then
        dotdmg = 7
    -- known breakpoints above this line. unknown breakpoints below. for unknown breakpoints, I divided the remaining skill equally
    elseif skillLvl > 223 then
        dotdmg = 6
    elseif skillLvl > 178 then
        dotdmg = 5
    elseif skillLvl > 133 then
        dotdmg = 4
    elseif skillLvl > 88 then
        dotdmg = 3
    elseif skillLvl > 43 then
        dotdmg = 2
    else
        dotdmg = 1
    end

    -- Do it!
    target:addStatusEffect(tpz.effect.BIO, dotdmg, 3, duration, 0, 15, 2)
    spell:setMsg(tpz.msg.basic.MAGIC_DMG)

    -- Try to kill same tier Dia (default behavior)
    if DIA_OVERWRITE == 1 and dia ~= nil then
        if dia:getPower() <= 2 then
            target:delStatusEffect(tpz.effect.DIA)
        end
    end

    return final
end
