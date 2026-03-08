-----------------------------------
-- Erratic Flutter
-- Family: Wamoura
-- Description: Deals Fire damage to enemies in range. Grants the effect of Haste.
-- Notes:
--  Wamoura version also deals Fire damage to targets around the wamoura.
--  While it does not overwrite most forms of Slowga, Slow II, Slow II TP moves,
--  Erratic Flutter does overwrite Hojo: Ni, Hojo: Ichi, and Slow.
--  Player Blue magic version is wind element instead of fire.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 2.75, 2.75, 2.75 }
    params.element        = xi.element.FIRE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.FIRE
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    xi.mobskills.mobBuffMove(mob, xi.effect.HASTE, 4500, 0, 180)

    return info.damage
end

return mobskillObject
