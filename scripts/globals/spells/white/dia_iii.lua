-----------------------------------
-- Spell: Dia III
-- Lowers an enemy's defense and gradually deals light elemental damage.
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/utils")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
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
    local resist = xi.magic.applyResistance(caster, target, spell, params)
    -- Get the resisted damage
    dmg = dmg * resist
    -- Add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = xi.magic.addBonuses(caster, spell, target, dmg)
    -- Add in target adjustment
    dmg = xi.magic.adjustForTarget(target, dmg, spell:getElement())
    -- Add in final adjustments including the actual damage dealt
    local final = xi.magic.finalMagicAdjustments(caster, target, spell, dmg)

    -- Calculate duration and bonus
    local merits = caster:getMerit(xi.merit.DIA_III)
    local duration = xi.magic.calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local dotBonus = caster:getMod(xi.mod.DIA_DOT) -- Dia Wand

    spell:setMsg(xi.msg.basic.MAGIC_DMG) -- hit for initial damage
    xi.magic.handleBurstMsg(caster, target, spell)
    -- Check for Bio
    local bio = target:getStatusEffect(xi.effect.BIO)

    if bio == nil then -- if no bio, just add dia dot
        if caster:isPC() then
            target:addStatusEffect(xi.effect.DIA, 3 + dotBonus, 3, merits, 0, 15, 3)
        else
            target:addStatusEffect(xi.effect.DIA, 3 + dotBonus, 3, duration, 0, 15, 3)
        end
    elseif
        bio:getSubPower() <= 15 or
        (xi.settings.main.BIO_OVERWRITE == 1 and bio:getSubPower() <= 20) -- also erase same tier bio if BIO_OVERWRITE option is on (non-default)
    then -- erase lower tier bio and add dia dot
        target:delStatusEffect(xi.effect.BIO)
        if caster:isPC() then
            target:addStatusEffect(xi.effect.DIA, 3 + dotBonus, 3, merits, 0, 15, 3)
        else
            target:addStatusEffect(xi.effect.DIA, 3 + dotBonus, 3, duration, 0, 15, 3)
        end
    end

    return final
end

return spellObject
