-----------------------------------
--  Venom Shell
--
--  Description: Releases a toxic gas from its shell, poisoning targets in an area of effect.
--  Type: Enfeebling
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown radial
--  Notes: Poison is about 24/tic. The Nightmare Uragnite uses an enhanced version that also inflicts Plague.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = math.floor(mob:getMainLvl() / 2) - 2
    power = math.max(power, 16) -- Floor of 16 damage per tick

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 0, 120))

    return xi.effect.POISON
end

return mobskillObject
