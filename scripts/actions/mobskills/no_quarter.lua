-----------------------------------
-- No Quarter
-- Family: Humanoid (August)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 3
    params.fTP            = { 0.35, 0.35, 0.35 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3
    -- TODO: Possible accuracy mod

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    mob:setMod(xi.mod.DMGPHYS, 0) -- Remove the Phyisical damage taken effect
    mob:setLocalVar('DaybreakEndTime', GetSystemTime())
    skill:setFinalAnimationSub(0)

    return info.damage
end

return mobskillObject
