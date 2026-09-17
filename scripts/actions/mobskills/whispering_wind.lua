-----------------------------------
-- Whispering Wind
-- Family: Avatar (Garuda)
-- Description: Restores HP
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.primaryMessage = xi.msg.basic.SELF_HEAL
    params.baseHeal       = mob:getMaxHP()
    params.fTP =
    {
        { tp = 1000, modifier = 68 / 1024 },
        { tp = 2000, modifier = 101 / 1024 },
        { tp = 3000, modifier = 134 / 1024 }, -- TODO: Do not have a capture for 2000-3000 TP. Using linear scale for now.
    }

    return xi.mobskills.mobHealMove(mob, target, skill, action, params)
end

return mobskillObject
