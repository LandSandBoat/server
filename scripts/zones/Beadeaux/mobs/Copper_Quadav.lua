-----------------------------------
-- Area: Beadeaux
--  Mob: Copper Quadav
-- Note: PH for Da'Dha Hundredmask
-- Involved in Mission 3-1 (Bastok)
-----------------------------------
local ID = require("scripts/zones/Beadeaux/IDs")
require("scripts/globals/missions")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    if (player:getCurrentMission(BASTOK) == xi.mission.id.bastok.THE_FOUR_MUSKETEERS) then
        local missionStatus = player:getMissionStatus(player:getNation())

        if (missionStatus > 1 and missionStatus < 22) then
            player:setMissionStatus(player:getNation(), missionStatus + 1)
        end
    end
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.DA_DHA_HUNDREDMASK_PH, 10, 5400) -- 90 minutes
end

return entity
