-----------------------------------
-- Area: La Theine Plateau
--  Mob: Lumbering Lambert
-----------------------------------
local ID = zones[xi.zone.LA_THEINE_PLATEAU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.BATTERING_RAM[1]]  = ID.mob.LUMBERING_LAMBERT, -- -372 -16 -6
    [ID.mob.BATTERING_RAM[2]]  = ID.mob.LUMBERING_LAMBERT, -- -117 -1 -136
    [ID.mob.LUMBERING_LAMBERT] = ID.mob.BLOODTEAR, -- Lumbering can't spawn if Bloodtear is up
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 156)
    xi.magian.onMobDeath(mob, player, optParams, set{ 579 })
end

entity.onMobDespawn = function(mob)
    local params =
    {
        doNotEnablePhSpawn = true,
    }
    xi.mob.phOnDespawn(mob, ID.mob.BLOODTEAR, 10, 75600, params) -- 21 hours. do not re-enable lumbering lambert spawn after killing bloodtear
end

return entity
