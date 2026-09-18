-----------------------------------
-- Healing Ruby
-- Family: Avatar (Carbuncle)
-- Description: Restores HP.
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
        -- TODO: Capture fTPs. What mob uses this? If used, can it target self or does it target an ally?
        { tp = 1000, modifier = 0.03250 },
        { tp = 2000, modifier = 0.08125 },
        { tp = 3000, modifier = 0.13000 },
    }

    return xi.mobskills.mobHealMove(mob, target, skill, action, params)
end

return mobskillObject
