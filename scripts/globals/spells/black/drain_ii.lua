-----------------------------------
-- Spell: Drain II
-- Drain functions only on skill level!!
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    --calculate raw damage (unknown function  -> only dark skill though) - using http://www.bluegartr.com/threads/44518-Drain-Calculations
    -- also have small constant to account for 0 dark skill
    local dmg = 20 + (1.236 * caster:getSkillLevel(xi.skill.DARK_MAGIC))

    if dmg > (caster:getSkillLevel(xi.skill.DARK_MAGIC) + 85) then
        dmg = (caster:getSkillLevel(xi.skill.DARK_MAGIC) + 85)
    end

    --get resist multiplier (1x if no resist)
    local params = {}
    params.diff = caster:getStat(xi.mod.INT)-target:getStat(xi.mod.INT)
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.DARK_MAGIC
    params.bonus = 1.0
    params.damageSpell = true

    local resist = xi.magic.applyResistance(caster, target, spell, params)
    --get the resisted damage
    dmg = dmg * resist
    --add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = xi.magic.addBonuses(caster, spell, target, dmg)
    --add in target adjustment
    dmg = xi.magic.adjustForTarget(target, dmg, spell:getElement())
    --add in final adjustments

    if dmg < 0 then
        dmg = 0
    end

    -- Upyri: ID 4105
    if target:isMob() and (target:isUndead() or target:getPool() == 4105) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- No effect
        return 0
    end

    -- Don't drain more HP than the target has left
    if target:getHP() < dmg then
        dmg = target:getHP()
    end

    dmg = xi.magic.finalMagicAdjustments(caster, target, spell, dmg)

    local leftOver = (caster:getHP() + dmg) - caster:getMaxHP()
    local overHeal = (leftOver / caster:getMaxHP()) * 100
    if caster:hasStatusEffect(xi.effect.WEAKNESS) then
        overHeal = (leftOver / (caster:getBaseHP() + caster:getMod(xi.mod.HP))) * 100
    end

    if leftOver > 0 then
        caster:addStatusEffect(xi.effect.MAX_HP_BOOST, overHeal, 0, 60)
    end

    caster:addHP(dmg)

    return dmg
end

return spellObject
