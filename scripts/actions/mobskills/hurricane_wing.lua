-----------------------------------
-- Hurricane Wing
-- Family: Wyrm
-- Description: Deals hurricane-force wind damage to enemies within a very wide area of effect. Additional effect: Blind
-- Notes: Used only by Dragua, Fafnir, Nidhogg, Cynoprosopi, Wyrm, and Odzmanouk. The blinding effect does not last long
--        but is very harsh. The attack is wide enough to generally hit an entire alliance.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if not target:isInfront(mob, 128) then
        return 1
    elseif mob:getAnimationSub() == 1 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 3.250, 3.625, 4.000 }
    params.element        = xi.element.WIND
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.WIND
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local power = 100

        if mob:getPool() == xi.mobPool.NIDHOGG then
            power = 160
        end

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, power, 0, 30)
    end

    return info.damage
end

return mobskillObject
