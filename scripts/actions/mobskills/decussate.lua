-----------------------------------
--  Decussate
--
--  Description: Performs a cross attack on nearby targets.
--  Type: Magical
--  Utsusemi/Blink absorb: 2-3 shadows?
--  Range: Less than or equal to 10.0
--  Notes: Unlocked at 20% hp
--
-- TODO: Umeboshi: "This is a physical skill, will adjust in mobPhysicalMove() pass"
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getHPP() > 20 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 3.0, 3.0, 3.0 }
    params.element        = xi.element.EARTH
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.EARTH
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
