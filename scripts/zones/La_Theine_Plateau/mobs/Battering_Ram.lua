-----------------------------------
-- Area: La Theine Plateau
--  Mob: Battering Ram
-----------------------------------
local ID = zones[xi.zone.LA_THEINE_PLATEAU]
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    if not xi.mob.phOnDespawn(mob, ID.mob.BLOODTEAR_PH, 10, 75600) then -- 21 hours
        xi.mob.phOnDespawn(mob, ID.mob.LUMBERING_LAMBERT_PH, 10, 1200) -- 20 min
    end
end

return entity
