-----------------------------------
-- Putrid Breath
-- Description: Deals Dark damage to enemies.
-- Notes: Deals Breath damage and follows corresponding damage reductions but damage is not based on HP.
-- Notes: Only used by Cirrate Christelle.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg() -- TODO: Currently balanced around weapon damage.
    params.fTP            = { 8, 8, 8 }
    params.element        = xi.element.DARK
    params.attackType     = xi.attackType.BREATH
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    if skill:getID() == xi.mobSkill.PUTRID_BREATH_2 then
        params.primaryMessage = xi.msg.basic.HIT_DMG
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
