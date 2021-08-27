-----------------------------------
-- Area: Western Adoulin
--  NPC: Volgoi
-- Type: Standard NPC
-- !pos -154 4 -22 256
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local SOA_Mission = player:getCurrentMission(SOA)
    if ((SOA_Mission >= xi.mission.id.soa.BEAUTY_AND_THE_BEAST) and (SOA_Mission <= xi.mission.id.soa.SALVATION)) then
        -- Speech while Arciela is 'kidnapped'
        player:startEvent(151)
    else
        -- Standard dialogue
        player:startEvent(501)
        -- Volgoi also has 579 associated with him, but it's the exact same dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
