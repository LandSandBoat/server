-----------------------------------
-- Area: Appolyon
--  NPC: Sentinel_Column
-- !pos 643 0 -609 38
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 2127) then
        player:startEvent(221, 65)
    elseif npcUtil.tradeHas(trade, {1909, 1910, 1987, 1988}) then
        player:startEvent(221, 33)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(221, 31)
end

entity.onEventUpdate = function(player, csid, option)
    player:updateEvent(
        0,
        GetServerVariable("[SW_Apollyon]Time"), -- SW Apollyon
        GetServerVariable("[NW_Apollyon]Time"), -- NW Apollyon
        GetServerVariable("[SE_Apollyon]Time"), -- SE Apollyon
        GetServerVariable("[NE_Apollyon]Time"), -- NE Apollyon
        GetServerVariable("[Central_Apollyon]Time"), -- Central Apollyon
        GetServerVariable("[CS_Apollyon]Time")  -- CS Apollyon
    )
end

entity.onEventFinish = function(player, csid, option)
end
return entity
