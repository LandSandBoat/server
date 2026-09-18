-----------------------------------
-- Exuviation
-- Family: Wamoura
-- Description: Erases all negative effects on the mob and heals an amount for each removed.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local effectCount = 0
    local dispel      = mob:eraseStatusEffect()

    while (dispel ~= xi.effect.NONE)
    do
        effectCount = effectCount + 1
        dispel = mob:eraseStatusEffect()
    end

    -- TODO: This formula seems wrong, either not based on the average Wamoura or the level scaling is incorrect.
    -- Some captures from Mount Zhayolm:

    -- Level 82(1 effect) 494 HP Restored
    -- Level 80(1 effect) 479
    -- Level 80(2 effect) 1437

    local params = {}

    params.primaryMessage = xi.msg.basic.SELF_HEAL
    params.baseHeal       = 699 + (mob:getMainLvl() - 70) * 10 * effectCount
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
