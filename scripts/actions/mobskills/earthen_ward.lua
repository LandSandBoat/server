-----------------------------------
-- Earthen Ward
-- Titan grants Stoneskin to party members within area of effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local base = mob:getMainLvl() * 2 + 50

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.STONESKIN, base, 0, 180))

    return xi.effect.STONESKIN
end

return mobskillObject
