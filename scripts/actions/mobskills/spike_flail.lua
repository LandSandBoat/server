-----------------------------------
-- Spike Flail
-- Family: Wyrm
-- Deals extreme damage in a threefold attack to targets behind the user.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) then -- TODO: We should probably handle these effect exceptions in the mob script.
        return 1
    elseif mob:hasStatusEffect(xi.effect.SUPER_BUFF) then
        return 1
    elseif mob:hasStatusEffect(xi.effect.INVINCIBLE) then
        return 1
    elseif mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) then
        return 1
    elseif target:isInfront(mob, 128) then
        return 1
    elseif mob:getAnimationSub() == 1 then -- Not used while flying
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 3
    params.fTP            = { 4.0, 4.0, 4.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
