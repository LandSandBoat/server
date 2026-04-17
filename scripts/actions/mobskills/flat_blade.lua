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
    params.fTP            = { 1.25, 1.25, 1.25 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Eventually, we will want to rework mobStatusEffectMove() to accept MACC modifiers based on TP instead of this.
        if math.random(1, 100) < skill:getTP() / 3 then
            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4) -- TODO: Capture stun duration
        end
    end

    if mob:getPool() == xi.mobPool.QUBIA_ARENA_TRION then
        target:showText(mob, zones[xi.zone.QUBIA_ARENA].text.FLAT_LAND)
    end

    return info.damage
end

return mobskillObject
