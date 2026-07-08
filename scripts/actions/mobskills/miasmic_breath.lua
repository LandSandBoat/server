-----------------------------------
-- Miasmic Breath
-- Family: Morbol
-- Description: A toxic odor is exhaled on any players in a fan-shaped area of effect.
-- Notes: Deals Breath damage and follows corresponding damage reductions but damage is not based on HP.
-- Used by Cirrate Christelle
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage           = mob:getWeaponDmg() -- TODO: Mob is likely balanced around weapon damage atm instead of getMainLvl().
    params.fTP                  = { 4, 4, 4 }
    params.element              = xi.element.DARK
    params.attackType           = xi.attackType.BREATH
    params.damageType           = xi.damageType.DARK
    params.shadowBehavior       = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    -- Note: Miasmic Breath (1604) uses Msg 185(xi.msg.basic.DAMAGE)
    -- Note: Miasmic Breath (1605) uses Msg 1(xi.msg.basic.HIT_DMG)
    -- https://youtu.be/QHcGtTR_xQg?t=879
    if skill:getID() == xi.mobSkill.MIASMIC_BREATH_2 then
        params.primaryMessage = xi.msg.basic.HIT_DMG
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 50, 3, 60)
    end

    return info.damage
end

return mobskillObject
