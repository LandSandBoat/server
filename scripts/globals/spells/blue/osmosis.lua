-----------------------------------
-- Spell: Osmosis
-- Steals an enemy's HP and one beneficial status effect. Ineffective against undead
-- Spell cost: 47 MP
-- Monster Type: Vorageans
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 5
-- Stat Bonus: MND+3 CHR-2
-- Level:84
-- Casting Time: 4 seconds
-- Recast Time: 120 seconds
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)

    local dmg = 7 * (caster:getSkillLevel(xi.skill.BLUE_MAGIC) * 0.11)
    --get resist multiplier (1x if no resist)
    local params = {}
    params.diff = caster:getStat(xi.mod.MND)-target:getStat(xi.mod.MND)
    params.attribute = xi.mod.MND
    params.skillType = xi.skill.BLUE_MAGIC
    params.bonus = 1.0
    local resist = applyResistance(caster, target, spell, params)
    --get the resisted damage
    dmg = dmg*resist
    --add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = addBonuses(caster, spell, target, dmg)
    --add in target adjustment
    dmg = adjustForTarget(target, dmg, spell:getElement())
    --add in final adjustments

    if (dmg < 0) then
        dmg = 0
    end

    if (target:isUndead()) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return dmg
    end

    if (target:getHP() < dmg) then
        dmg = target:getHP()
    end

    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.DARK
    dmg = BlueFinalAdjustments(caster, target, spell, dmg, params)
    caster:addHP(dmg)

    -- Steal status
    local stealResist = applyResistanceAbility(caster, target, xi.magic.ele.WIND, 0, 0)
    local stealChance = math.random(1, 100)
    local stolen = 0

    if stealResist > 0.0625 and stealChance < 90 then
        stolen = caster:stealStatusEffect(target)
        if stolen ~= 0 then
            spell:setMsg(xi.msg.basic.MAGIC_STEAL)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    end
    ---

    return dmg
end

return spell_object
