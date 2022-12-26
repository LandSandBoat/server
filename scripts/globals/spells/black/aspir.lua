-----------------------------------
-- Spell: Aspir
-- Drain functions only on skill level!!
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    --calculate raw damage (unknown function  -> only dark skill though) - using http://www.bluegartr.com/threads/44518-Drain-Calculations
    -- also have small constant to account for 0 dark skill
    local dmg = 5 + 0.375 * caster:getSkillLevel(xi.skill.DARK_MAGIC)
    local mpDiff = caster:getMaxMP() - caster:getMP()

    --get resist multiplier (1x if no resist)
    local params = {}
    params.diff = caster:getStat(xi.mod.INT)-target:getStat(xi.mod.INT)
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.DARK_MAGIC
    params.bonus = 1.0
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

    dmg = dmg * xi.settings.main.DARK_POWER

    if target:isUndead() or target:hasImmunity(xi.immunity.ASPIR) then
        dmg = 0
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- No effect
        return dmg
    end

    -- If player has Diabolos's Pole equipped and dark weather, MP drained is enhanced by 25%
    if
        not caster:isMob() and
        caster:getCharVar("Diaboloss_Pole") == 1 and
        (caster:getWeather() == xi.weather.GLOOM or caster:getWeather() == xi.weather.DARKNESS)
    then
        dmg = dmg + (dmg * 0.25)
    end

    if target:getMP() > dmg then
        caster:addMP(dmg)
        target:delMP(dmg)
    else
        dmg = target:getMP()
        caster:addMP(dmg)
        target:delMP(dmg)
    end

    spell:setMsg(xi.msg.basic.MAGIC_DRAIN_MP, math.min(dmg, mpDiff))

    return math.min(dmg, mpDiff)
end

return spellObject
