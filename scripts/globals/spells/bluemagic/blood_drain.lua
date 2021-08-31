-----------------------------------
-- Spell: Blood Drain
-- Steals an enemy's HP. Ineffective against undead
-- Spell cost: 10 MP
-- Monster Type: Giant Bats
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 2
-- Stat Bonus: HP-5, MP+5
-- Level: 20
-- Casting Time: 4 seconds
-- Recast Time: 90 seconds
-- Magic Bursts on: Compression, Gravitation, Darkness
-- Combos: None
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local dmg = 1 + (0.705 * caster:getSkillLevel(xi.skill.BLUE_MAGIC))
    local params = {}
    params.diff = caster:getStat(xi.mod.MND)-target:getStat(xi.mod.MND)
    params.attribute = xi.mod.MND
    params.skillType = xi.skill.BLUE_MAGIC
    params.bonus = 1.0
    local resist = applyResistance(caster, target, spell, params)
    dmg = dmg*resist
    dmg = addBonuses(caster, spell, target, dmg)
    dmg = adjustForTarget(target, dmg, spell:getElement())
    if (dmg > (caster:getSkillLevel(xi.skill.BLUE_MAGIC) + 20)) then
        dmg = (caster:getSkillLevel(xi.skill.BLUE_MAGIC) + 20)
    end

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

    return dmg
end

return spell_object
