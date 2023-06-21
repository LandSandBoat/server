-----------------------------------
-- Spell: Bio IV
-- Deals dark damage that weakens an enemy's attacks and gradually reduces its HP.
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local basedmg = caster:getSkillLevel(xi.skill.DARK_MAGIC) / 4
    local params = {}
    params.dmg = basedmg
    params.multiplier = 3
    params.skillType = xi.skill.DARK_MAGIC
    params.attribute = xi.mod.INT
    params.hasMultipleTargetReduction = false
    params.diff = caster:getStat(xi.mod.INT)-target:getStat(xi.mod.INT)
    params.bonus = 1.0

    -- Calculate raw damage
    local dmg = calculateMagicDamage(caster, target, spell, params)
    -- Softcaps at 80, should always do at least 1
    dmg = utils.clamp(dmg, 1, 80)
    -- Get resist multiplier (1x if no resist)
    local resist = applyResistance(caster, target, spell, params)
    -- get the resisted damage
    dmg = dmg * resist
    -- Add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = addBonuses(caster, spell, target, dmg)
    -- Add in target adjustment
    dmg = adjustForTarget(target, dmg, spell:getElement())
    -- Add in final adjustments including the actual damage dealt
    local final = finalMagicAdjustments(caster, target, spell, dmg)

    -- Calculate duration
    local duration = 180

    -- Check for Dia
    local dia = target:getStatusEffect(xi.effect.DIA)

    -- Calculate DoT effect (rough, though fairly accurate)
    local dotdmg = 5 + math.floor(caster:getSkillLevel(xi.skill.DARK_MAGIC) / 60)

    -- Do it!
    target:addStatusEffect(xi.effect.BIO, dotdmg, 3, duration, 0, 25, 4)
    spell:setMsg(xi.msg.basic.MAGIC_DMG)

    -- Try to kill same tier Dia (default behavior)
    if xi.settings.main.DIA_OVERWRITE == 1 and dia ~= nil then
        if dia:getPower() <= 4 then
            target:delStatusEffect(xi.effect.DIA)
        end
    end

    return final
end

return spellObject
