-----------------------------------
-- Flat Blade
-- Family: Humanoid Sword Weaponskill
-- Description: Stuns enemy. Chance of stunning varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getPool() ~= xi.mobPool.QUBIA_ARENA_TRION then
        mob:messageBasic(xi.msg.basic.READIES_WS, 0, 35)
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 1.0, 1.0, 1.0 }
    -- params.str_wSC        = 0.3 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4)
    end

    if mob:getPool() == xi.mobPool.QUBIA_ARENA_TRION then
        target:showText(mob, zones[xi.zone.QUBIA_ARENA].text.FLAT_LAND)
    end

    return info.damage
end

return mobskillObject
