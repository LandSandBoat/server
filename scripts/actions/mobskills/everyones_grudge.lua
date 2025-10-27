-----------------------------------
--  Everyones Grudge
--
--  Notes: Invokes collective hatred to spite a single target.
--   Damage done is 5x the amount of tonberries you have killed! For NM's using this it is 50 x damage.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:isNM() then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power   = 5
    local realDmg = power * target:getCharVar('EVERYONES_GRUDGE_KILLS') -- Damage is 5 times the amount you have killed

    -- TODO: Verify if this is accurate
    if target:isPet() then
        realDmg = power * math.random(30, 100)
    end

    if mob:isNM() then
        realDmg = realDmg * 10 -- sets the multiplier to 50 for NM's
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
