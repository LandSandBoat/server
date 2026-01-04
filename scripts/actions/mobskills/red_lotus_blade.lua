-----------------------------------
-- Red lotus Blade
--
-- Description: Deals fire elemental damage. Damage varies with TP.
-- Type: Physical
-- Utsusemi/Blink absorb: 1 Shadow?
-- Range: Melee
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

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if mob:getPool() == xi.mobPool.QUBIA_ARENA_TRION then -- Trion: uBia_Arena only
        target:showText(mob, zones[xi.zone.QUBIA_ARENA].text.RLB_LAND)
    elseif mob:getPool() == xi.mobPool.THRONE_ROOM_VOLKER then -- Volker: Throne_Room only
        target:showText(mob, zones[xi.zone.THRONE_ROOM].text.FEEL_MY_PAIN)
    end

    local damage = mob:getWeaponDmg() * 4

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, 1.25, xi.mobskills.magicalTpBonus.DMG_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    return damage
end

return mobskillObject
