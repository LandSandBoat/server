-----------------------------------
-- Sickle Slash
-- Family: Spider
-- Description: Deals critical damage. Chance of critical hit varies with TP.
-- TODO: Split lua for Spiders and Ghrah
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getFamily() == 122 and -- TODO: Set proper skill lists for Ghrah.
        mob:getAnimationSub() ~= 2
    then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getWeaponDmg()
    params.numHits          = 1
    params.fTP              = { 2.0, 2.0, 2.0 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.BLUNT
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier = { 1.5, 1.5, 1.5 }
    params.canCrit          = true
    params.criticalChance   = { 0.10, 0.20, 0.25 } -- TODO: Capture crit rate

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
