-----------------------------------
-- Bomb Toss - Suicide
-- Family: Goblins
-- Description: Bomb toss back fires, killing the mob as well as dealing Fire damage around it based on it's remaining HP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- Notorious monsters and mobs in Dynamis shouldn't explode.
    if
        mob:isMobType(xi.mobType.NOTORIOUS) or
        mob:isInDynamis()
    then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = skill:getMobHP() / 3
    params.fTP            = { 1, 1, 1 }
    params.element        = xi.element.FIRE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.FIRE
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

mobskillObject.onMobSkillFinalize = function(mob, skill)
    mob:setHP(0)
end

return mobskillObject
