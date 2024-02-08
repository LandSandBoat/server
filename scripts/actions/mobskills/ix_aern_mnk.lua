-----------------------------------
-- Hundred Fists
-- Meant for Ix'Aern (MNK)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getPool() == 4661 and
        mob:getHPP() <= 50 and
        mob:getLocalVar('BracerMode') == 1
    then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.HUNDRED_FISTS, 1, 0, 45)
    mob:setLocalVar('BracerMode', 2)
    skill:setMsg(xi.msg.basic.USES)
    return xi.effect.HUNDRED_FISTS
end

return mobskillObject
