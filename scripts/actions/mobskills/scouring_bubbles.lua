-----------------------------------
-- Scouring Bubbles
-- Family: Mihli Aliapoh
-- Description: Deals damage in an Area of Effect.
-- Notes: Used by Mihli Aliapoh (Trust)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: This is likely a physical move despite the water visual effects. JPWiki mentions there have been cases of it missing.
    params.baseDamage     = mob:getWeaponDmg()
    params.fTP            = { 12.25, 12.25, 12.25 } -- TODO: Capture fTPs
    params.element        = xi.element.WATER
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.WATER
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
