-----------------------------------
-- Deep Kiss
-- Steal one effect
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- https://docs.google.com/spreadsheets/d/1TnrBzUAQ0hyuFVIjf5OLviIfhGw4vxN1x_4zv9gG4N4/edit?gid=368168805#gid=368168805&range=H32
    if mob:getPool() == xi.mobPool.PHOEDME then
        local numEffectsStolen = 0

        -- Steal all statuses until none are left
        while mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE) ~= 0 do
            numEffectsStolen = numEffectsStolen + 1
        end

        -- TODO: capture no effect
        skill:setMsg(xi.msg.basic.EFFECT_DRAINED) -- This might be the wrong message if no effects are stolen, however SKILL_NO_EFFECT etc don't print a message but EFFECT_DRAINED does

        return numEffectsStolen
    end

    local skillMsg = xi.mobskills.mobDrainStatusEffectMove(mob, target)

    -- TODO: capture no effect
    skill:setMsg(xi.msg.basic.EFFECT_DRAINED) -- This might be the wrong message if no effects are stolen, however SKILL_NO_EFFECT etc don't print a message but EFFECT_DRAINED does

    if skillMsg ~= xi.msg.basic.EFFECT_DRAINED then
        return 0
    end

    return 1
end

return mobskillObject
