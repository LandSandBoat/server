-----------------------------------
-- Everyone's Rancor
--
-- Notes: Invokes rancor to spite a single target.
--
-- Damage is 50x the amount of Tonberries slain.
-- Only used by certain NMs, generally only once
-- and when they have reached a certain percentage
-- of HP (usually 25%).
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:isNM() and
        mob:getHP() / mob:getMaxHP() <= 0.25 and
        mob:getLocalVar("everyonesRancorUsed") == 0
    then
        mob:setLocalVar("everyonesRancorUsed", 1)
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local grudgeKills = 0
    local player = nil

    if target:isPC() then
        grudgeKills = target:getCharVar("EVERYONES_GRUDGE_KILLS")
        player = target
    elseif target:isPet() then
        grudgeKills = target:getMaster():getCharVar("EVERYONES_GRUDGE_KILLS")
        player = target:getMaster()
    end

    local realDmg = 50 * grudgeKills -- Damage is 50 times the amount you have killed

    if
        player and
        player:getEquipID(xi.slot.NECK) == xi.items.UGGALEPIH_NECKLACE
    then
        realDmg = math.floor(realDmg * (1 - (player:getTP() / 3000)))
        player:setTP(0)
    end

    target:takeDamage(realDmg, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)
    return realDmg
end

return mobskillObject
