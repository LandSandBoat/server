-----------------------------------
-- Bomb Toss - Suicide
-- Throws a bomb at an enemy. Sometimes backfires.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- notorious monsters shouldn't explode, nor dynamis
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) or mob:isInDynamis() then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local bombTossHPP = skill:getMobHPP() / 100
    local power = math.random(12, 18)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * power * bombTossHPP, xi.element.FIRE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:setHP(0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end

return mobskillObject
