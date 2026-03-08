-----------------------------------
--  Unblest Jambiya
--  Family: Qutrub
--  Description: Steals HP from targets in an area of effect.
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: AoE 15'
--  Notes: Used only by certain NM's when their primary sword isn't broken.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 0 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: This is a physical skill. Will fix in mobPhysicalMove() PR
    params.baseDamage     = mob:getWeaponDmg()
    params.fTP            = { 2.00, 2.00, 2.00 }
    params.element        = xi.element.DARK
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, info.damage))
    end

    return info.damage
end

return mobskillObject
