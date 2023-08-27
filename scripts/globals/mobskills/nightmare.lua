---------------------------------------------
-- Nightmare
-- AOE Sleep with Bio dot
---------------------------------------------
require("scripts/globals/mobskills")
---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.SLEEP_I
    local power = 20
    local tick = 3
    local duration = 60     -- Unresisted, 20 ticks at 21 hp/tick = 420hp per target
    local subEffect = xi.effect.BIO
    local subPower = 21 -- 21 HP/tick drain

    -- Adjust parameters for CoP Diabolos.  This is an estimate, will need some battletesting
    local copDiabolos = 16818177
    if mob:getID() >= copDiabolos and mob:getID() <= copDiabolos + 14 then  -- three possible instances of Diabolos
        power = 10
        duration = 30
        subPower = 14       -- Unresisted, 10 ticks at 14 hp/tick = 140hp per target
    end
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, tick, duration, subEffect, subPower))

    return typeEffect
end

return mobskillObject
