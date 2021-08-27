-----------------------------------
-- Area: Temenos
--  NPC: Scanning_Device
-- !pos 586 0 66 37
-----------------------------------
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 2127) then
        player:startEvent(121, 257)
    elseif npcUtil.tradeHas(trade, {1986, 1908, 1907}) then
        player:startEvent(121, 17)
    elseif npcUtil.tradeHas(trade, 1904) then
        player:startEvent(121, 33)
    elseif npcUtil.tradeHas(trade, 1905) then
        player:startEvent(121, 65)
    elseif npcUtil.tradeHas(trade, 1906) then
        player:startEvent(121, 129)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(121, 15)
end

entity.onEventUpdate = function(player, csid, option)
    local time = 0
    switch (option): caseof {
        [1] = function() time = GetServerVariable("[Temenos_Northern_Tower]Time") end, -- Northern Tower
        [2] = function() time = GetServerVariable("[Temenos_Eastern_Tower]Time") end, -- Eastern Tower
        [3] = function() time = GetServerVariable("[Temenos_Western_Tower]Time") end, -- Western Tower
        [4] = function() time = GetServerVariable("[Central_Temenos_4th_Floor]Time") end, -- Central 4th
        [5] = function() time = GetServerVariable("[Central_Temenos_3rd_Floor]Time") end, -- Central 3rd
        [6] = function() time = GetServerVariable("[Central_Temenos_2nd_Floor]Time") end, -- Central 2nd
        [7] = function() time = GetServerVariable("[Central_Temenos_1st_Floor]Time") end, -- Central 1st
        [8] = function() time = GetServerVariable("[Central_Temenos_Basement]Time") end, -- Central Basement
    }
    player:updateEvent(0, time, 0, 0, 0, 0, 0, 0)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
