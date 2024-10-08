-----------------------------------
-- Bomb Toss - Suicide
-- Throws a bomb at an enemy. Sometimes backfires.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- notorious monsters shouldn't explode, nor dynamis
    if mob:isMobType(xi.mobType.NOTORIOUS) or mob:isInDynamis() then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = math.floor(mob:getWeaponDmg() * math.random(12, 18) * skill:getMobHPP() / 100)

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    mob:setHP(0)

    return damage
end

return mobskillObject
