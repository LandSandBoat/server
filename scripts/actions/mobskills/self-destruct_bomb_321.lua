-----------------------------------
-- Self-Destruct (3, 2, 1...)
-- Family: Bomb
-- Description: Deals massive fire damage to enemies within range. Damage scales 1:1 with remaining HP.
-- Notes: Used by Time Bomb in the BCNM "3, 2, 1..." when time reaches 0.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = 9999 + mob:getHP()
    params.fTP            = { 2.5, 2.5, 2.5 }
    params.element        = xi.element.FIRE
    params.attackType     = xi.attackType.BREATH
    params.damageType     = xi.damageType.FIRE
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

mobskillObject.onMobSkillFinalize = function(mob, skill)
    mob:setHP(0)
end

return mobskillObject
