-----------------------------------
-- Orcish Counterstance
-- Used only by Orcs in Wings of the Goddess Areas.
-- Certain NMs may have a higher power version of the xi.effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getContinentID() == xi.continent.THE_SHADOWREIGN_ERA then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- local power = 10
    -- local duration = 60
    local typeEffect = xi.effect.COUNTERSTANCE

    -- if Conquerer Bakgodek then
        -- power = 50? He's not implemented yet anyway :P
    -- end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 10, 0, 60))

    return typeEffect
end

return mobskillObject
