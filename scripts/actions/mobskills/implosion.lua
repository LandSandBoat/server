-----------------------------------
-- Implosion
-- Family: Shadow Lord
-- Description: Channels a wave of negative energy, damaging all targets in very wide area of effect.
-- Notes: Used during phase 2 of Shadow Lord mission fight.
-- Also used by Shadow Lord in past but with different properties. https://wiki.ffo.jp/html/19868.html
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Version used in [S](Past) reportedly deals 50% Max HP Damage + Knockback
    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 1, 1, 1 } -- TODO: Capture fTPs
    params.element        = xi.element.DARK
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
