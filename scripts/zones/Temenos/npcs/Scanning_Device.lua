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
    elseif npcUtil.tradeHas(trade, { 1986, 1908, 1907 }) then
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
        [1] = function() time = GetServerVariable("[TEMENOS_NORTHERN_TOWER]Time") end,
        [2] = function() time = GetServerVariable("[TEMENOS_EASTERN_TOWER]Time") end,
        [3] = function() time = GetServerVariable("[TEMENOS_WESTERN_TOWER]Time") end,
        [4] = function() time = GetServerVariable("[CENTRAL_TEMENOS_4TH_FLOOR]Time") end,
        [5] = function() time = GetServerVariable("[CENTRAL_TEMENOS_3RD_FLOOR]Time") end,
        [6] = function() time = GetServerVariable("[CENTRAL_TEMENOS_2ND_FLOOR]Time") end,
        [7] = function() time = GetServerVariable("[CENTRAL_TEMENOS_1ST_FLOOR]Time") end,
        [8] = function() time = GetServerVariable("[CENTRAL_TEMENOS_BASEMENT]Time") end,
    }
    player:updateEvent(0, time, 0, 0, 0, 0, 0, 0)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
