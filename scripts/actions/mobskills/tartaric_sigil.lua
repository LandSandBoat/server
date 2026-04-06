-----------------------------------
-- Tartaric Sigil
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() * 3
    params.fTP            = { 1.25, 1.25, 1.25 }
    params.element        = xi.element.DARK
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        local duration = (skill:getTP() / 100) / 6 -- 2 sec min, 5 sec max
        if duration < 2 then
            duration = 2
        end

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AMNESIA, 1, 0, duration)
    end

    if info.damage > 0 then
        mob:addTP(134)
    end

    return info.damage
end

return mobskillObject
