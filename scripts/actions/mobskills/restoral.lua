-----------------------------------
-- Restoral
-- Family: Gears
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
    params.baseHeal       = math.randomInt(900, 1400) -- TODO: Capture power/fTP
    params.fTP =
    {
        { tp = 1000, modifier = 1.00 },
        { tp = 2000, modifier = 1.00 },
        { tp = 3000, modifier = 1.00 },
    }

    if mob:getPool() == xi.mobPool.ARMED_GEARS then
        params.fTP =
        {
            { tp = 1000, modifier = 2.50 },
            { tp = 2000, modifier = 2.50 },
            { tp = 3000, modifier = 2.50 },
        }
    end

    --[[
    The only calculations available on the net are for the players blue magic version,
    which does not seem to fit with retail in game observations on the mobskill version..
    So math.randomFloat(0, 1) for now!
    ]]

    return xi.mobskills.mobHealMove(mob, target, skill, action, params)
end

return mobskillObject
