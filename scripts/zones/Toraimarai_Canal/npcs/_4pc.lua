-----------------------------------
-- Area: Toraimarai Canal
--  NPC: Marble Door
-- Involved In Windurst Mission 7-1
-- !pos 132 12 -19 169
-----------------------------------
local ID = require("scripts/zones/Toraimarai_Canal/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_SIXTH_MINISTRY or player:hasCompletedMission(tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.THE_SIXTH_MINISTRY) then
        for i = ID.mob.HINGE_OILS_OFFSET, ID.mob.HINGE_OILS_OFFSET + 3 do
            if not GetMobByID(i):isDead() then
                player:startEvent(70, 0, 0, 0, 1) -- at least one hinge oil is alive
                return
            end
        end
        player:startEvent(70, 0, 0, 0, 2) -- all four hinge oils are dead
    else
        player:startEvent(70)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
