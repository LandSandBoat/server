-----------------------------------
-- Extremely Bad Breath
-- A horrific case of halitosis instantly K.O.'s any players in a fan-shaped area of effect.
--
-- Description
-- Family: Morbol
-- Type: Breath
-- Can be dispelled: N/A
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown cone
-- Notes: Only used by Evil Oscar, Cirrate Christelle, Lividroot Amooshah, Eccentric Eve, Deranged Ameretat, and Melancholic Moira.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmg = target:getHP()
    target:setHP(0)
    return dmg
end

return mobskillObject
