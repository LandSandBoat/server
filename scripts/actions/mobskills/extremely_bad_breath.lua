-----------------------------------
-- Extremely Bad Breath
-- Description : A horrific case of halitosis instantly K.O.'s any players in a fan-shaped area of effect.
-- Family: Morbol
-- Type: Breath
-- Range: 12' AoE
-- Utsusemi/Blink absorb: Ignores shadows
-- Notes: Only used by Evil Oscar, Cirrate Christelle, Lividroot Amooshah, Eccentric Eve, Deranged Ameretat, and Melancholic Moira.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if math.random(1, 100) <= target:getMod(xi.mod.DEATHRES) then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    else
        skill:setMsg(xi.msg.basic.FALL_TO_GROUND)
        target:setHP(0)
    end

    return 0
end

return mobskillObject
