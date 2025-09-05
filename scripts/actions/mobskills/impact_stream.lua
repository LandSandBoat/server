-----------------------------------
--  Impact Stream
--  Description: 50% Defense Down, Stun
--  Type: Magical
--  Wipe Shadows
--  Range: 10.0' AoE
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() * 2, xi.element.NONE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4)

    -- Defense down power scales with TP
    -- 1000-1999 = 50
    -- 2000-2999 = 55
    -- 3000      = 60
    local power = 50 + 5 * math.floor((skill:getTP() - 1000) / 1000)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, power, 0, 60)

    return damage
end

return mobskillObject
