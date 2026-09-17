-----------------------------------
-- Healing Breath III
-- Family: Wyvern Pet
-- Description: Restores HP for target
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
    params.additiveHeal   = 60
    params.fTP =
    {
        -- TODO: What mob uses this? Does it scale with TP?
        { tp = 1000, modifier = 63 / 256 },
        { tp = 2000, modifier = 63 / 256 },
        { tp = 3000, modifier = 63 / 256 },
    }

    return xi.mobskills.mobHealMove(mob, target, skill, action, params)
end

return mobskillObject
