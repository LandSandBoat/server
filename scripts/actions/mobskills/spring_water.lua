-----------------------------------
-- Spring Water
-- Family: Avatar (Leviathan)
-- Description: Restores hit points and cures some status ailments.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    -- TODO: Does mob version erase debuffs?

    local params = {}

    params.primaryMessage = xi.msg.basic.SELF_HEAL
    params.baseHeal       = mob:getMaxHP()
    params.fTP =
    {
        { tp = 1000, modifier = 64 / 1024 },
        { tp = 2000, modifier = 88 / 1024 },
        { tp = 3000, modifier = 112 / 1024 }, -- TODO: Do not have a capture for 2000-3000 TP. Using linear scale for now.
    }

    return xi.mobskills.mobHealMove(mob, target, skill, action, params)
end

return mobskillObject
