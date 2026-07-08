-----------------------------------
-- Leaping Cleave
-- Family: Qutrub
-- Description: Performs a jumping slash on a single target. Additional Effect: Stun
-- Notes: Used only when wielding their initial sword.
-- TODO: Jimmayus spreadsheet says this is also used in dagger form?
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

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 2.25, 2.25, 2.25 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local duration = xi.mobskills.calculateDuration(mob:getTP(), 15, 30)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, duration)
    end

    return info.damage
end

return mobskillObject
