-----------------------------------
-- Red lotus Blade
-- Family: Humanoid Sword Weaponskill
-- Description: Deals Fire elemental damage. Damage varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getPool() ~= xi.mobPool.QUBIA_ARENA_TRION and
        mob:getPool() ~= xi.mobPool.THRONE_ROOM_VOLKER
    then
        mob:messageBasic(xi.msg.basic.READIES_WS, 0, 34)
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 5.0, 5.0, 5.0 } -- TODO: Capture fTPs
    params.element        = xi.element.FIRE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.FIRE
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    if mob:getPool() == xi.mobPool.QUBIA_ARENA_TRION then -- Trion: QuBia_Arena only
        target:showText(mob, zones[xi.zone.QUBIA_ARENA].text.RLB_LAND)
    elseif mob:getPool() == xi.mobPool.THRONE_ROOM_VOLKER then -- Volker: Throne_Room only
        target:showText(mob, zones[xi.zone.THRONE_ROOM].text.FEEL_MY_PAIN)
    end

    return info.damage
end

return mobskillObject
