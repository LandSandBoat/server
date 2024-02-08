-----------------------------------
--  Viscid Emission
--  Inflicts amnesia in an area of effect.
--  Type: Magical (Enfeebling)
--  Range: Unknown cone
--  Utsusemi/Blink absorb: Ignores shadows
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- Subpower 100 prevents removal by Ecphoria Ring
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AMNESIA, 1, 0, 60, 100))
    return xi.effect.AMNESIA
end

return mobskillObject
