-----------------------------------
-- Ranged Attack
-- Family: Humanoid/Beastman (Varies)
-- Description: Deals a ranged attack to a single target.
-- Note: Used by RNG and NIN mobs as their ranged attack.
--       Gigas have their own ranged attack skill called "Catapult"
--       Trolls have their own ranged attack skill called "Zarraqa"
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 1.5, 1.5, 1.5 } -- TODO: Mobs get more base damage on their ranged weapon slot already. Do we need the 1.5 fTP?
    params.attackType     = xi.attackType.RANGED
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.skipParry      = true
    params.skipGuard      = true
    params.skipBlock      = true

    -- Note: Normal mob ranged attacks that call this script can not critical hit.
    --       Normal mobskill style ranged attacks do not display sweet spot messaging.

    -- TODO: Fomor type mobs that should use the player style ranged attacks are currently use this script.
    --       Their ranged attacks can crit.

    local info = xi.mobskills.mobRangedMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
