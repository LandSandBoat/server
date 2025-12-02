-----------------------------------
-- Regeneration
--
-- Description: Adds a Regen xi.effect.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.REGEN) then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local tpFactor = utils.clamp(3 * (skill:getTP() - 1000) / 1000, 0, 6)
    local power    = 5 + tpFactor

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.REGEN, power, 3, 300))

    return xi.effect.REGEN
end

return mobskillObject
