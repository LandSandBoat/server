-----------------------------------
-- Origin
-- Family: Humanoid Scythe Weaponskill
-- Description: Absorbs HP and MP. Damage varies with TP.
-- TODO: Range like Catastrophe? Is HP/MP Drain 1:1? BG Wiki claims it is clamped by current HP/MP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}
    local targetHP = target:getHP()
    local targetMP = target:getMP()

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 3.0, 6.0, 9.0 }
    -- params.str_wSC     = 0.6 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.int_wSC     = 0.6 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        if not target:isUndead() then
            mob:addHP(utils.clamp(info.damage, 0, targetHP))
        end

        if targetMP > 0 then
            local mpDrain = utils.clamp(info.damage, 0, targetMP)

            target:delMP(mpDrain)
            mob:addMP(mpDrain)
        end
    end

    return info.damage
end

return mobskillObject
