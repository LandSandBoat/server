-----------------------------------
-- Area: Western Adoulin
--  NPC: Kipligg
-- Type: Standard NPC and Mission NPC,
-- Involved with Missions: '...Into the Fire', 'Done and Delivered'
-- !pos -32 0 22 256
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local SOA_Mission = player:getCurrentMission(SOA)

    if (SOA_Mission < xi.mission.id.soa.LIFE_ON_THE_FRONTIER) then
        -- Dialogue prior to joining colonization effort
        player:startEvent(571)
    elseif (SOA_Mission == xi.mission.id.soa.INTO_THE_FIRE) then
        -- Finishes SOA Mission: '...Into the Fire'
        player:startEvent(155)
    elseif ((SOA_Mission >= xi.mission.id.soa.MELVIEN_DE_MALECROIX) and (SOA_Mission <= xi.mission.id.soa.COURIER_CATASTROPHE)) then
        -- Reminds player where to go for SOA Mission: 'Melvien de Malecroix'
        player:startEvent(162)
    elseif (SOA_Mission == xi.mission.id.soa.DONE_AND_DELIVERED) then
        -- Finishes SOA Mission: 'Done and Delivered'
        player:startEvent(157)
    elseif (SOA_Mission == xi.mission.id.soa.MINISTERIAL_WHISPERS) then
        -- Reminds player where to go for SOA Mission: 'Ministerial Whispers'
        player:startEvent(163)
    else
        -- Dialogue after joining colonization effort
        player:startEvent(589)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 155) then
        -- Finishes SOA Mission: '...Into the Fire'
        player:completeMission(xi.mission.log_id.SOA, xi.mission.id.soa.INTO_THE_FIRE)
        player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.MELVIEN_DE_MALECROIX)
    elseif (csid == 157) then
        -- Finishes SOA Mission: 'Done and Delivered'
        player:completeMission(xi.mission.log_id.SOA, xi.mission.id.soa.DONE_AND_DELIVERED)
        player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.MINISTERIAL_WHISPERS)
    end
end

return entity
