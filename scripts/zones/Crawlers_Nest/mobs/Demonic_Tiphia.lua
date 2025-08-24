-----------------------------------
-- Area: Crawlers' Nest (197)
--  Mob: Demonic Tiphia
-----------------------------------
local ID = zones[xi.zone.CRAWLERS_NEST]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.DEMONIC_TIPHIA - 7] = ID.mob.DEMONIC_TIPHIA, -- -101.000 -1.000 285.000
    [ID.mob.DEMONIC_TIPHIA - 6] = ID.mob.DEMONIC_TIPHIA, -- -103.000 -1.000 311.000
    [ID.mob.DEMONIC_TIPHIA - 3] = ID.mob.DEMONIC_TIPHIA, -- -89.000 -1.000 301.000
    [ID.mob.DEMONIC_TIPHIA - 2] = ID.mob.DEMONIC_TIPHIA, -- -75.000 -1.000 299.000
}

entity.onMobFight = function(mob, target)
    -- captures show cure v repeatedly every 15 sec below 50% health
    if
        mob:getHPP() <= 50 and
        not xi.combat.behavior.isEntityBusy(mob) and
        GetSystemTime() > mob:getLocalVar('cureDelay')
    then
        mob:castSpell(xi.magic.spell.CURE_V, mob)
        mob:setLocalVar('cureDelay', GetSystemTime() + 15)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 236)
end

return entity
