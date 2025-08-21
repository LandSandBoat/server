-----------------------------------
-- Self-Destruct
-- Notes: This ability is used by the special Friar's Lanterns in Halvung that drop Smoke-filled Glass
--        Self-destruct is only witnessed to be used by these bombs when grown to their full size
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:isMobType(xi.mobType.NOTORIOUS) or
        (mob:getAnimationSub() < 3 and mob:getModelId() == 282) -- Growing Bomb conditions
    then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = math.floor(mob:getWeaponDmg() * skill:getMobHPP() / 5)

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    mob:setHP(0)

    return damage
end

return mobskillObject
