-----------------------------------
-- Pollen
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
        { tp = 1000, modifier = 147 / 1024 },
        { tp = 2000, modifier = 147 / 1024 },
        { tp = 3000, modifier = 147 / 1024 },
    }

    -- TODO: Is the NM heal potency random or based on fTP?
    if mob:isNM() then
        params.fTP =
        {
            { tp = 1000, modifier = math.randomInt(147, 441) / 1024 },
            { tp = 2000, modifier = math.randomInt(147, 441) / 1024 },
            { tp = 3000, modifier = math.randomInt(147, 441) / 1024 },
        }
    end

    return xi.mobskills.mobHealMove(mob, target, skill, action, params)
end

return mobskillObject
