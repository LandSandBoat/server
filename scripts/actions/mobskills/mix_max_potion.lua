-----------------------------------
-- Mix: Max Potion - Restores 700 HP.
-- Family: Trust- Monberaux
-- Note the subtle name difference from 'Max Potion'.
-- This feels like a localization error otherwise.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.primaryMessage = xi.msg.basic.SELF_HEAL
    params.baseHeal       = 700
    params.fTP =
    {
        { tp = 1000, modifier = 1.00 },
        { tp = 2000, modifier = 1.00 },
        { tp = 3000, modifier = 1.00 },
    }

    return xi.mobskills.mobHealMove(mob, target, skill, action, params)
end

return mobskillObject
