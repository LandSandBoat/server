-----------------------------------
-- Firespit
-- Family: Mamool Ja
-- Description: Deals Fire damage to an enemy.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: This move needs more thorough research on damage and mechanics(See notes below on skillIDs).
    params.baseDamage      = mob:getMainLvl()
    params.fTP             = { 4, 4, 4 }
    params.element         = xi.element.FIRE
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.FIRE
    params.shadowBehavior  = xi.mobskills.shadowBehavior.NUMSHADOWS_3
    params.dStatMultiplier = 1

    -- There are two versions of this skill (SkillIDs 1733 and 1923). 1733 is used by Brown Mamool Ja and 1923 is used by Blue Mamool Ja(Usually mage types).
    -- Blue types ignore shadows and deal fire damage. Brown types consume shadows.

    -- TODO: Capture AOE type for both skill IDs(Conal AOE, AOE near target, Single Target, etc)

    -- Blue Mamool Ja ignore shadows.
    if skill:getID() == xi.mobSkill.FIRESPIT_BLUE_MAMOOLJA then
        params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
