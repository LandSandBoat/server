-----------------------------------
-- Auto Attack: Trample
-- Family: Monoceros
-- Description: Charges forward, dealing high damage to,(400-1000) and lowering the MP (10-30%) of, anyone in its path.
-- Notes: No message is displayed in the chat log.
--        Video showing 25% mp lost on hit: https://youtu.be/Jj9pWfSr1c0?t=26
--
-- This move is triggered during onMobFight and is only advertised by the fact that DI runs towards random players in range and has dust under his feet
--
-- When Dark Ixion's HP is low, he can do up to 3 Tramples in succession.
--     Can be avoided easily by moving out of its path.
--     May charge in the opposite, or an entirely random, direction from the one he is currently facing.
--     Will load a set number of targets in his path before ramming forward.
--     Occasionally, a person in his path will not be hit, as well as those wandering in its path after it has begun its charge.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 3.0, 3.0, 3.0 }
    params.attackType     = xi.attackType.RANGED
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1 -- TODO: Capture shadowBehavior
    params.primaryMessage = xi.msg.basic.HIT_DMG

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local remainingMPP = 1 - math.random(10, 30) / 100
        target:setMP(target:getMP() * remainingMPP)
    end

    return info.damage
end

return mobskillObject
