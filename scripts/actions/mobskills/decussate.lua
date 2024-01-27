-----------------------------------
--  Decussate
--
--  Description: Performs a cross attack on nearby targets.
--  Type: Magical
--  Utsusemi/Blink absorb: 2-3 shadows?
--  Range: Less than or equal to 10.0
--  Notes: Only used by Gulool Ja Ja when below 35% health.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getPool() == 1846 and mob:getHP() < mob:getMaxHP() / 100 * 35 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1.2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.element.EARTH, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, math.random(2, 3) * info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end

return mobskillObject
