-----------------------------------
-- Core Meltdown (Ghrah)
-- Reactor core fails and self-destructs, damaging any nearby targets.
-- Note: Very rare, estimated 5% chance.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:isMobType(xi.mobType.NOTORIOUS) then
        return 1
    elseif mob:getAnimationSub() ~= 0 then -- Form check (Must be ball form)
        return 1
    elseif mob:getHPP() > 30 then -- Can only be used under 30% HP
        return 1
    elseif math.random(1, 100) >= 5 then -- Here's the 95% chance to not blow up
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = skill:getMobHP() / 2
    params.fTP            = { 1, 1, 1 }
    params.element        = xi.element.FIRE -- TODO: The element/damage type should be based off of the Ghrah's element.
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.ELEMENTAL
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

mobskillObject.onMobSkillFinalize = function(mob, skill)
    -- Note: If no targets in range, the explosion will not animate but the mob will still die. This is accurate retail behavior.
    mob:setHP(0)
end

return mobskillObject
