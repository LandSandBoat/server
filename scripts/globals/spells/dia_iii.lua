-----------------------------------
-- Spell: Dia III
-- Lowers an enemy's defense and gradually deals light elemental damage.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local basedmg = caster:getSkillLevel(xi.skill.ENFEEBLING_MAGIC) / 4
    local params = {}
    params.dmg = basedmg
    params.multiplier = 5
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.hasMultipleTargetReduction = false
    params.diff = 0
    params.bonus = 1.0

    -- Calculate raw damage
    local dmg = basedmg
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
    local duration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local dotBonus = caster:getMod(xi.mod.DIA_DOT) -- Dia Wand

    -- Check for Bio
    local bio = target:getStatusEffect(xi.effect.BIO)
    -- Try to kill same tier Bio (non-default behavior)
    if BIO_OVERWRITE == 1 and bio ~= nil then
        if bio:getPower() <= 3 then
            target:delStatusEffect(xi.effect.BIO)
        else
            -- Do it!
            if bio ~= nil and bio:getPower() <= 3 then -- if mob has bio up through level 3
                spell:setMsg(xi.msg.basic.MAGIC_DMG) -- hit for initial damage, but no dot effects
            else -- otherwise hit for initial damage and add dia dot, remove bio dot
                target:addStatusEffect(xi.effect.DIA, 3 + dotBonus, 3, duration, 0, 20, 3)
                spell:setMsg(xi.msg.basic.MAGIC_DMG)
                target:delStatusEffect(xi.effect.BIO)
            end
        end
    end

    return final
end

return spell_object
