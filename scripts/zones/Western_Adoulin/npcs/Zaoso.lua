-----------------------------------
-- Area: Western Adoulin
--  NPC: Zaoso
-- !pos -94 3 -11 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.SOA) >= xi.mission.id.soa.LIFE_ON_THE_FRONTIER then
        player:startEvent(574)
    else
        -- Dialogue prior to joining colonization effort
        player:startEvent(506)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
