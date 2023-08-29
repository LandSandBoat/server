-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Kuhn Tsahnpri
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Based on scripts/zones/Mhaura/Dieh_Yamilsiah.lua
    local timer = 1152 - ((os.time() - 1009810800)%1152)
    local direction = 0 -- Arrive, 1 for depart
    local waiting = 431 -- Offset for Nashmau

    if timer <= waiting then
        direction = 1 -- Ship arrived, switch dialog from 'arrive' to 'depart'
    else
        timer = timer - waiting -- Ship hasn't arrived, subtract waiting time to get time to arrival
    end

    player:startEvent(236, timer, direction)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
