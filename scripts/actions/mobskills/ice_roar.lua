-----------------------------------
-- Ice Roar
-- Family: Gigas
-- Description: Emits the roar of an impact event, dealing damage in a fan-shaped area of effect. Ice damage
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Need more research on if this is a magical or physical skill
    -- TODO : Verify spell interrupt effect (If interrupt, then likely physical)
    params.baseDamage      = mob:getMainLvl() + 2
    params.fTP             = { 1.5, 1.5, 1.5 } -- TODO: Capture fTP scalings
    params.element         = xi.element.ICE
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.ICE
    params.shadowBehavior  = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
