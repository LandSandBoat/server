-----------------------------------
--  Everyones Grudge
--
--  Notes: Invokes collective hatred to spite a single target.
--   Damage done is 5x the amount of tonberries you have killed! For NM's using this it is 50 x damage.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
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

    local realDmg = 5 * grudgeKills -- Damage is 5 times the amount you have killed

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
