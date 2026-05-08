-----------------------------------
-- Catastrophe
-- Family: Humanoid Scythe Weaponskill
-- Description: Converts damage dealt into own HP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}
    local targetHP = target:getHP()

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 2.75, 2.75, 2.75 }
    -- params.agi_wSC     = 0.4 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.int_wSC     = 0.4 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        if not target:isUndead() then
            local drain = math.floor(info.damage * math.random(30, 70) / 100)

            mob:addHP(utils.clamp(drain, 0, targetHP))
        end
    end

    return info.damage
end

return mobskillObject
