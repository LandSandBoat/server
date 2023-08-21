-----------------------------------
-- Area: La Vaule [S]
--  Mob: Orcish Bowshooter
-- Note: PH for Hawkeyed Dnatbat
-----------------------------------
local ID = zones[xi.zone.LA_VAULE_S]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.HAWKEYED_DNATBAT_PH, 10, 3600) -- 1 hour
end

return entity
