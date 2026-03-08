-----------------------------------
-- Pile Pitch
-- Family: Omega
-- Description:  Reduces target's HP to 5% of its maximum value. Additional Effect: Bind
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Jimmayus spreadsheet says this is a physical skill. Fix in mobPhysicalMove() pass.
    params.baseDamage           = target:getHP() * 0.90 -- TODO: Need captures of fTPs/damage.
    params.fTP                  = { 1, 1, 1 }
    params.element              = xi.element.NONE
    params.attackType           = xi.attackType.MAGICAL
    params.damageType           = xi.damageType.NONE
    params.shadowBehavior       = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.skipDamageAdjustment = true
    params.skipMagicBonusDiff   = true

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, xi.attackType.MAGICAL, xi.damageType.NONE, { breakBind = false })

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 30)
        mob:resetEnmity(target) -- TODO: Check hate reset type (Aggro pause vs full enmity reset.)
    end

    return info.damage
end

return mobskillObject
