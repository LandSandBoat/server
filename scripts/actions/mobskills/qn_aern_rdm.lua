-----------------------------------
-- Chainspell
-- Meant for Qn'aern (RDM) with Ix'Aern encounter
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getPool() == 3269 and mob:getHPP() <= 70 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.CHAINSPELL, 1, 0, 60)

    skill:setMsg(xi.msg.basic.USES)
    return xi.effect.CHAINSPELL
end

return mobskillObject
