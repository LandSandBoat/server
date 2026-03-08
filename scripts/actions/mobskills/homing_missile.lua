-----------------------------------
-- Homing Missle
-- Family: Chariots
-- Description: Deals near death damage to target and surrounding allies. Resets hate.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- TODO: JPWiki states this can only be used on targets in front. Need captures
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage           = target:getHP() * 0.90
    params.fTP                  = { 1, 1, 1 }
    params.element              = xi.element.NONE -- TODO: Capture element (Possibly Fire?)
    params.attackType           = xi.attackType.MAGICAL
    params.damageType           = xi.damageType.ELEMENTAL
    params.shadowBehavior       = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    -- TODO: Is it reduced by Shell/MDB?

    -- TODO: Long-Bowed Chariot mechanics
    -- https://www.bg-wiki.com/ffxi/Long-Bowed_Chariot

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        mob:resetEnmity(target)
    end

    return info.damage
end

return mobskillObject
