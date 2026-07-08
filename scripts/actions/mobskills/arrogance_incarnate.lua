-----------------------------------
-- Arrogance Incarnate
-- Description: Delivers an unavoidable area attack. Damage varies with HP and TP.
-- Type: Breath
-- Element: None
-- Stat Modifier: 80% DEX
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local tp  = skill:getTP()
    local hp  = mob:getHP()
    local dmg = math.floor(hp * (math.floor(0.016 * tp) + 16) / 256)

    if tp > 2000 then -- 2001 - 3000
        dmg = math.floor(hp * (math.floor(0.072 * tp) - 96) / 256)
    end

    dmg = math.floor(dmg * 2.5)
    dmg = math.floor(dmg * xi.combat.damage.calculateDamageAdjustment(target, false, false, false, true))
    dmg = math.floor(dmg * xi.spells.damage.calculateAbsorption(target, xi.element.NONE, false))
    dmg = math.floor(dmg * xi.spells.damage.calculateNullification(target, xi.element.NONE, false, true))
    dmg = math.floor(target:handleSevereDamage(dmg, false))
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
