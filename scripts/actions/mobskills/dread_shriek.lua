-----------------------------------
-- Dread Shriek
-- Description: An unsettling shriek paralyzes targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 10' radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

-- https://docs.google.com/spreadsheets/d/1YBoveP-weMdidrirY-vPDzHyxbEI2ryECINlfCnFkLI/edit?gid=57955395#gid=57955395
-- TODO: what's the boosted para rate for NMs? needs research
-- Cyranuce M Cutauleon has a very strong paralyze from this
mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 45

    if mob:isNM() then
        power = 90
    end

    -- Cyranuce M Cutauleon
    if mob:getPool() == 884 then
        power = 100 -- yes, really
    end

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, power, 0, 60))

    return xi.effect.PARALYSIS
end

return mobskillObject
