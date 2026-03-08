-----------------------------------
-- Exuviation
-- Family: Wamoura
-- Type: Healing and Full Erase
-- Range: Self
-- Notes: Erases all negative effects on the mob and heals an amount for each removed.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local effectCount = 0
    local dispel = mob:eraseStatusEffect()

    while (dispel ~= xi.effect.NONE)
    do
        effectCount = effectCount + 1
        dispel = mob:eraseStatusEffect()
    end

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    -- TODO: This formula seems wrong, either not based on the average Wamoura or the level scaling is incorrect.
    -- Some captures from Mount Zhayolm:

    -- Level 82(1 effect) 494 HP Restored
    -- Level 80(1 effect) 479
    -- Level 80(2 effect) 1437
    return xi.mobskills.mobHealMove(mob, (699 + (mob:getMainLvl() - 70) * 10) * effectCount)
end

return mobskillObject
