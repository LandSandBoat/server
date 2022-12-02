-----------------------------------
-- Spell: Drain
-- Drain functions only on skill level!!
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    --calculate raw damage (unknown function  -> only dark skill though) - using http://www.bluegartr.com/threads/44518-Drain-Calculations
    -- also have small constant to account for 0 dark skill
    local dmg = 10 + (1.035 * caster:getSkillLevel(xi.skill.DARK_MAGIC))

    if dmg > (caster:getSkillLevel(xi.skill.DARK_MAGIC) + 20) then
        dmg = (caster:getSkillLevel(xi.skill.DARK_MAGIC) + 20)
    end

    --get resist multiplier (1x if no resist)
    local params = {}
    params.diff = caster:getStat(xi.mod.INT)-target:getStat(xi.mod.INT)
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.DARK_MAGIC
    params.bonus = 1.0
    local resist = applyResistance(caster, target, spell, params)
    --get the resisted damage
    dmg = dmg * resist
    --add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = addBonuses(caster, spell, target, dmg)
    --add in target adjustment
    dmg = adjustForTarget(target, dmg, spell:getElement())
    --add in final adjustments

    if dmg < 0 then
        dmg = 0
    end

    if target:getHP() < dmg then
        dmg = target:getHP()
    end

    if target:isUndead() then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- No effect
        return dmg
    end

    dmg = finalMagicAdjustments(caster, target, spell, dmg)

    caster:addHP(dmg)
    return dmg
end

return spellObject
