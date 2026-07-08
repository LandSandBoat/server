-- Vulcanian Impact
-- Family: Bomb
-- Description : Deals Fire damage to a single target.
-- Notes: Vulcanian Impact is only used by small or medium bombs in TOAU.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 2.0, 2.0, 2.0 } -- TODO: Capture fTP scaling @ 2k/3k
    params.element        = xi.element.FIRE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.FIRE
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    -- TOAU Bombs and Big Bomb NM
    if skill:getID() == xi.mobSkill.VULCANIAN_IMPACT_2 then
        params.fTP = { 4.0, 4.0, 4.0 }
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
