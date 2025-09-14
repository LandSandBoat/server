-----------------------------------
-- Pollen
-- Description: Restores HP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local potency = skill:getParam()

    if potency == 0 then
        potency = 12
    end

    -- TODO do this cleaner
    if mob:getName() == 'Beelzebub' or mob:getName() == 'Hell_Fly' then
        potency = 24 -- Double Potency for Infernal Swarm Mobs
    end

    potency = potency - math.random(0, potency / 4)

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * potency / 100)
end

return mobskillObject
