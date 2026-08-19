-----------------------------------
-- Debilitating Drone
-- Family: Fly
-- Description: Status down on two random stats.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local duration = xi.mobskills.calculateDuration(skill:getTP(), 30, 120)
    local effects  = utils.shuffle(
    {
        xi.effect.STR_DOWN,
        xi.effect.DEX_DOWN,
        xi.effect.VIT_DOWN,
        xi.effect.AGI_DOWN,
        xi.effect.INT_DOWN,
        xi.effect.MND_DOWN,
        xi.effect.CHR_DOWN,
    })

    local effectTable =
    {
        { effectId = effects[1], power = 8, duration = duration },
        { effectId = effects[2], power = 8, duration = duration },
    }

    return xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, {})
end

return mobskillObject
