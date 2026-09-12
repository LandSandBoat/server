-----------------------------------
-- Dukkeripen
-- Family: Lamia
-- Description: Self healing move
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getMainJob() == xi.job.COR then -- TODO: Set skill lists
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.primaryMessage = xi.msg.basic.SELF_HEAL
    params.baseHeal       = math.randomInt(350, 500) -- TODO: Capture HP power
    params.fTP =
    {
        -- TODO: Does it scale with TP?
        { tp = 1000, modifier = 1.00 },
        { tp = 2000, modifier = 1.00 },
        { tp = 3000, modifier = 1.00 },
    }

    return xi.mobskills.mobHealMove(mob, target, skill, action, params)
end

return mobskillObject
