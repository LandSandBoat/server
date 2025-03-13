-----------------------------------
-- Bomb Toss - Suicide
-- Throws a bomb at an enemy. Sometimes backfires.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- Notorious monsters and goblins in Dynamis do not explode.
    -- TODO: Adjust weighting between regular Bomb Toss and Bomb Toss Suicide.
    if mob:isMobType(xi.mobType.NOTORIOUS) or mob:isInDynamis() then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local params = {}

    params.baseDamage   = skill:getMobHP() / 3
    params.fTP          = 1
    params.element      = xi.element.FIRE

    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, params)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    mob:setHP(0)

    return damage
end

return mobskillObject
