-----------------------------------
-- Catharsis
-- Description: Restores HP. (12.5% of max HP)
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
        -- TODO: Does it scale with TP?
        { tp = 1000, modifier = 0.125 },
        { tp = 2000, modifier = 0.125 },
        { tp = 3000, modifier = 0.125 },
    }

    return xi.mobskills.mobHealMove(mob, target, skill, action, params)
end

return mobskillObject
