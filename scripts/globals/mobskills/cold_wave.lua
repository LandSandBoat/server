-----------------------------------
--  Cold Wave
--
--  Description: Deals ice damage that lowers Agility and gradually reduces HP of enemies within range.
--  Type: Magical (Ice)
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local powerFrost = mob:getMainLvl() / 5 * 0.6 + 6
    -- Agility debuff is -33 last for 60 seconds
    local powerAgi = 33
    local tick = 3
    local duration = powerAgi * tick

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FROST, powerFrost, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AGI_DOWN, powerAgi, tick, duration)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return dmg
end

return mobskillObject
