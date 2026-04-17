-----------------------------------
-- Damnation Dive
-- Family: Lesser Bird
-- Description: Deals physical damage to targets in a fan-shaped area of effect. Additional Effect: Stun
-- Notorious Monster / Nightmare version can critically strike and is handled in damnation_dive_nm.lua
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

-----------------------------------
-- onMobSkillCheck
-- Check for Ghrah family bird form.
-- If not in Bird form, then ignore.
-----------------------------------
mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getFamily() == 122 and -- TODO: Split this off into its own mobskill script.
        mob:getAnimationSub() ~= 3
    then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 2.0, 2.0, 2.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 15)
    end

    return info.damage
end

return mobskillObject
