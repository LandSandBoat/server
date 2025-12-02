-----------------------------------
-- Everyone's Rancor
--
-- Notes: Invokes rancor to spite a single target.
-- Damage is 50x the amount of Tonberries slain.
-- Only used by certain NMs, generally only once
-- and when they have reached a certain percentage
-- of HP (usually 25%).
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:isNM() and
        mob:getHP() / mob:getMaxHP() <= 0.25 and
        mob:getLocalVar('everyonesRancorUsed') == 0
    then
        mob:setLocalVar('everyonesRancorUsed', 1)
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local realDmg = 50 * target:getCharVar('EVERYONES_GRUDGE_KILLS')

    -- TODO: Verify if this is accurate
    if target:isPet() then
        realDmg = 50 * math.random(50, 100)
    end

    -- Uggalepih Necklace mitigation
    -- While worn, consumes all TP to mitigate damage at flat breakpoints
    -- 1500 TP = 50% reduction, 3000 TP = 100% reduction
    if
        target:isPC() and
        target:getEquipID(xi.slot.NECK) == xi.item.UGGALEPIH_NECKLACE
    then
        local tpFactor = 1 - 0.5 * math.floor(target:getTP() / 1500)
        realDmg        = math.floor(realDmg * tpFactor)

        target:setTP(0)
    end

    target:takeDamage(realDmg, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)

    return realDmg
end

return mobskillObject
