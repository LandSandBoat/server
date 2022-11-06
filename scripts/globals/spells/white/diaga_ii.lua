-----------------------------------
-- Spell: Diaga II
-- Lowers an enemy's defense and gradually deals light elemental damage.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local basedmg = caster:getSkillLevel(xi.skill.ENFEEBLING_MAGIC) / 4
    local params = {}
    params.dmg = basedmg
    params.multiplier = 3
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.hasMultipleTargetReduction = false
    params.diff = 0
    params.bonus = 1.0

    -- Calculate raw damage
    local dmg = basedmg
    -- Softcaps at 40, should always do at least 1
    dmg = utils.clamp(dmg, 1, 40)
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
    local duration = calculateDuration(120, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local dotBonus = caster:getMod(xi.mod.DIA_DOT) -- Dia Wand

    spell:setMsg(xi.msg.basic.MAGIC_DMG) -- hit for initial damage
    -- Check for Bio
    local bio = target:getStatusEffect(xi.effect.BIO)

    if  bio == nil then -- if no bio, add dia dot
        target:addStatusEffect(xi.effect.DIA, 2 + dotBonus, 3, duration, 0, 15, 2)
    elseif
        bio:getSubPower() == 10 or
        (xi.settings.main.BIO_OVERWRITE == 1 and bio:getSubPower() <= 15) -- also erase same tier bio if BIO_OVERWRITE option is on (non-default)
    then -- erase lower tier bio and add dia dot
        target:delStatusEffect(xi.effect.BIO)
        target:addStatusEffect(xi.effect.DIA, 2 + dotBonus, 3, duration, 0, 15, 2)
    end

    return final
end

return spellObject
