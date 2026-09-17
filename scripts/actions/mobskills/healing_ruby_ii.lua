-----------------------------------
-- Healing Ruby II
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
        -- Values were pulled from existing capture data on a mob with 20000 max HP.
        -- https://youtu.be/2mK9JEADUE4?t=398
        -- https://youtu.be/rk09lnDldAQ?t=805
        -- https://youtu.be/AcbiLX6hi6k?t=2479
        { tp = 1000, modifier = 80 / 1024 },
        { tp = 2000, modifier = 123 / 1024 },
        { tp = 3000, modifier = 169 / 1024 },
    }

    return xi.mobskills.mobHealMove(mob, target, skill, action, params)
end

return mobskillObject
