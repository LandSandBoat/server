-----------------------------------
-- Magic Mortar
-- Family: Automatons
-- Description: Deals Light damage to enemies within an area of effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- Wikis say Ob starts using this skill around 50%HP.
    -- Damage ranges 1500-2500~ based on mob's missing HP (Unsure if shell was calculated into this account or not or if it applies at all)

    params.baseDamage     = (mob:getMaxHP() - skill:getMobHP()) / 6 -- TODO: Capture more data for damage formula
    params.fTP            = { 1.00, 1.00, 1.00 } -- TODO: Capture fTPs
    params.element        = xi.element.LIGHT -- TODO: Light or None?
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.LIGHT
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    -- TODO: Affected by modifiers like shell, MDB, etc?

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
