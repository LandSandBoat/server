-----------------------------------
-- Restoral
-- Description: Restores HP.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    --[[
    The only calculations available on the net are for the players blue magic version,
    which does not seem to fit with retail in game observations on the mobskill version..
    So math.random() for now!
    ]]
    local heal = math.random(900, 1400)
    if mob:getPool() == 243 then
        heal = heal * 2.5
    end

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(mob, heal)
end

return mobskillObject
