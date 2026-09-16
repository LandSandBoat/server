-----------------------------------
-- Everyones Grudge
-- Family: Tonberry
-- Notes: Invokes collective hatred to spite a single target.
-- Damage done is 5x the amount of tonberries you have killed!
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:isNM() then -- TODO: Set skill lists
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage         = target:getCharVar('EVERYONES_GRUDGE_KILLS')
    params.fTP                = { 5.0, 5.0, 5.0 }
    params.element            = xi.element.NONE -- TODO: Unaspected or Dark?
    params.attackType         = xi.attackType.MAGICAL
    params.damageType         = xi.damageType.ELEMENTAL
    params.shadowBehavior     = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.skipMagicBonusDiff = true -- TODO: Capture if MDB reduces damage.

    -- TODO: Verify if this is accurate
    if target:isPet() then
        local master = target:getMaster()

        if master then
            params.baseDamage = master:getCharVar('EVERYONES_GRUDGE_KILLS')
        end
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    -- TODO: Capture what order this takes place. (Before or after Stoneskin)
    if
        target:isPC() and
        target:getEquipID(xi.slot.NECK) == xi.item.UGGALEPIH_NECKLACE
    then
        local tpFactor = 1 - 0.5 * math.floor(target:getTP() / 1500)

        info.damage = math.floor(info.damage * tpFactor)

        target:setTP(0)
    end

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
