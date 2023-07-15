-----------------------------------
-- Area: Chamber of Oracles
--  NPC: Cermet Door (Exit)
-- Involved in Zilart Mission 7
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Allow any player not on quest to open the door for now because of issue with
    -- BCNM exit that puts all players in the room with pedistals rather than
    -- the hallway
    if player:getCurrentMission(xi.mission.log_id.ZILART) ~= xi.mission.id.zilart.THE_CHAMBER_OF_ORACLES then
        player:startEvent(2, xi.ki.PRISMATIC_FRAGMENT, 300, 200, 100, 168)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
