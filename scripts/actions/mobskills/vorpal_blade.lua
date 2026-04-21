-----------------------------------
-- Vorpal Blade
-- Family: Humanoid Sword Weaponskill
-- Description: Delivers a four-hit attack. Chance of critical varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- TODO: Split this into a file for each mob family

    -- Handle Ghrah family humanoid form.
    -- If not in Paladin form, then ignore.
    if
        mob:getFamily() == 122 and
        mob:getAnimationSub() ~= 1
    then
        return 1
    elseif mob:getFamily() == 176 then
        -- Handle Mamool Ja BLU
        if
            mob:getAnimationSub() == 0 and
            mob:getMainJob() == xi.job.BLU
        then
            return 0
        else
            return 1
        end
    elseif mob:getPool() ~= xi.mobPool.THRONE_ROOM_VOLKER then
        mob:messageBasic(xi.msg.basic.READIES_WS, 0, 40)
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 4
    params.fTP            = { 1.0, 1.0, 1.0 }
    -- params.str_wSC        = 0.3 -- TODO: Capture if mobskill weaponskills have wSC.
    params.canCrit        = true
    params.criticalChance = { 0.1, 0.3, 0.5 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_4

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    if mob:getPool() == xi.mobPool.THRONE_ROOM_VOLKER then -- Volker@Throne_Room only
        target:showText(mob, zones[xi.zone.THRONE_ROOM].text.BLADE_ANSWER)
    end

    return info.damage
end

return mobskillObject
