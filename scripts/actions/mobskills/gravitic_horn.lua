-----------------------------------
-- Gravitic Horn
-- Family: Antlion (Used by Formiceros subspecies)
-- Description: Heavy wind, Throat Stab-like damage in a fan-shaped area of effect. Resets enmity.
-- Notes: If Orcus uses this, it gains an aura which inflicts Weight & Defense Down to targets in range.
--        Shell lowers the damage of this, and items like Jelly Ring can get you killed.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = target:getHP()
    params.fTP            = { 0.95, 0.95, 0.95 } -- TODO: Capture HP threshhold
    params.element        = xi.element.WIND
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.WIND
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    -- https://wiki.ffo.jp/html/24615.html
    -- TODO: There are unique mechanics on this skill. Need captures.
    -- Damage is sometimes throat stab style(current HP) and sometimes a normal elemental skill?
    -- May have distance or conal damage adjustment.

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
