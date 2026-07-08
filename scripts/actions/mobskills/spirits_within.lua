-----------------------------------
-- Spirits Within
-- Family: Humanoid Sword Weaponskill
-- Description: Delivers an unavoidable attack. Damage varies with HP and TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getPool() ~= xi.mobPool.THRONE_ROOM_VOLKER then
        mob:messageBasic(xi.msg.basic.READIES_WS, 0, 39)
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    if mob:getPool() == xi.mobPool.THRONE_ROOM_VOLKER then -- Volker@Throne_Room only
        target:showText(mob, zones[xi.zone.THRONE_ROOM].text.RETURN_TO_THE_DARKNESS)
    end

    local params = {}

    params.percentMultipier = xi.combat.physical.calculateTPfactor(skill:getTP(), { 0.0625, 0.1875, 0.46875 })
    params.damageCap        = mob:getMaxHP()
    params.element          = xi.element.NONE
    params.resistStat       = xi.mod.INT
    params.attackType       = xi.attackType.BREATH
    params.damageType       = xi.damageType.ELEMENTAL
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
