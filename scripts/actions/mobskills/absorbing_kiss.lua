-----------------------------------
-- Absorbing Kiss
-- Steal one effect
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numAttributesDrained = 1 -- Default for most cases

    -- https://docs.google.com/spreadsheets/d/1TnrBzUAQ0hyuFVIjf5OLviIfhGw4vxN1x_4zv9gG4N4/edit?gid=368168805#gid=368168805&range=H31
    -- pic of -7/-8 stat to the right of that
    if mob:getPool() == xi.mobPool.PEPPER then
        numAttributesDrained = 0 -- Reset in case of resists

        for i = xi.effect.STR_DOWN, xi.effect.CHR_DOWN do
            -- Capture indicates the drain value is either 7/8 based on the picture.
            -- This seems strange, but without better ways to test this we will pick it at random
            -- MND down had 27 seconds left but still had -8 MND, so this must not decay.
            -- Even if it were a half resist it would still have had several ticks to decay
            local msg = xi.mobskills.mobDrainAttribute(mob, target, i, math.random(7, 8), 0, 120)

            -- mobDrainAttribute returns either ATTR_DRAINED or SKILL_MISS currently
            if msg == xi.msg.basic.ATTR_DRAINED then
                numAttributesDrained = numAttributesDrained + 1
            end
        end

        if numAttributesDrained > 0 then
            skill:setMsg(xi.msg.basic.ATTR_DRAINED)
        else
            skill:setMsg(xi.msg.basic.SKILL_MISS)
        end

        return numAttributesDrained
    end

    local effectType = math.random(xi.effect.STR_DOWN, xi.effect.CHR_DOWN)

    skill:setMsg(xi.mobskills.mobDrainAttribute(mob, target, effectType, 10, 3, 120))

    return numAttributesDrained -- Should this return 0 if the ability had no effect? -- TODO: capture
end

return mobskillObject
