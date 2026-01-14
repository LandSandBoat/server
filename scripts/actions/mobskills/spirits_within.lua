-----------------------------------
-- Spirits Within
--
-- Description: Delivers an unavoidable attack. Damage varies with HP and TP.
-- Type: Magical/Breath
-- Utsusemi/Blink absorb: Ignores shadows and most damage reduction.
-- Range: Melee
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getPool() ~= xi.mobPool.THRONE_ROOM_VOLKER then
        mob:messageBasic(xi.msg.basic.READIES_WS, 0, 39)
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if mob:getPool() == xi.mobPool.THRONE_ROOM_VOLKER then -- Volker@Throne_Room only
        target:showText(mob, zones[xi.zone.THRONE_ROOM].text.RETURN_TO_THE_DARKNESS)
    end

    -- Should produce 1000 - 3750 @ full HP using the player formula, assuming 8k HP for AA EV.
    -- dmg * 2.5, as wiki claims ~2500 at 100% HP, until a better formula comes along.
    local tp  = skill:getTP()
    local hp  = mob:getHP()
    local dmg = math.floor(hp * (math.floor(0.016 * tp) + 16) / 256)
    if tp > 2000 then -- 2001 - 3000
        dmg = math.floor(hp * (math.floor(0.072 * tp) - 96) / 256)
    end

    dmg = math.floor(dmg * 2.5)

    -- Believe it or not, it's been proven to be breath damage.
    dmg = math.floor(dmg * xi.spells.damage.calculateDamageAdjustment(target, false, false, false, true))
    dmg = math.floor(dmg * xi.spells.damage.calculateAbsorption(target, xi.element.NONE, false))
    dmg = math.floor(dmg * xi.spells.damage.calculateNullification(target, xi.element.NONE, false, true))
    dmg = math.floor(target:handleSevereDamage(dmg, false))

    -- Handling phalanx
    dmg = utils.handlePhalanx(target, dmg)

    if dmg < 0 then
        return 0
    end

    dmg = utils.handleStoneskin(target, dmg)

    if dmg > 0 then
        target:wakeUp()
        target:updateEnmityFromDamage(mob, dmg)
    end

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.ELEMENTAL)
    return dmg
end

return mobskillObject
