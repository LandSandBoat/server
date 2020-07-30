---------------------------------------------
-- Orcish Counterstance
-- Used only by Orcs in Wings of the Goddess Areas.
-- Certain NMs may have a higher power version of the tpz.effect.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/zone")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:getContinentID() == tpz.continent.THE_SHADOWREIGN_ERA) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local power = 10
    local duration = 60
    local typeEffect = tpz.effect.COUNTERSTANCE

    -- if ( Conquerer Bakgodek ) then
        -- power = 50? He's not implemented yet anyway :P
    -- end

    skill:setMsg(MobBuffMove(mob, typeEffect, 10, 0, 60))

    return typeEffect
end
