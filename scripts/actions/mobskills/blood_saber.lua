-----------------------------------
-- Blood Drain
-- Family: Skeletons
-- Family: Steals an enemy's HP. Ineffective against undead.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage         = mob:getMainLvl() + 2
    params.fTP                = { 1.5, 1.5, 1.5 }
    params.element            = xi.element.NONE
    params.damageType         = xi.damageType.NONE
    params.shadowBehavior     = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    params.skipMagicBonusDiff = true
    params.dStatMultiplier    = 1

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)
    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.HP, info.damage, info.attackType, info.damageType))
    end

    return info.damage
end

return mobskillObject
