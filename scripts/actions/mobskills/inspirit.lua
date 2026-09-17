-----------------------------------
-- Inspirit
-- Family: Trust - Lehko Habhoka
-- Description: Restores HP to nearby allies.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.primaryMessage = xi.msg.basic.SELF_HEAL
    params.baseHeal       = mob:getHP()
    params.fTP = -- TODO: Capture fTPs
    {
        { tp = 1000, modifier = 73 / 256 },
        { tp = 2000, modifier = 73 / 256 },
        { tp = 3000, modifier = 73 / 256 },
    }

    return xi.mobskills.mobHealMove(mob, target, skill, action, params)
end

return mobskillObject
