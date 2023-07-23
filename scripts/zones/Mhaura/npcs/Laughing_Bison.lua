-----------------------------------
-- Area: Mhaura
--  NPC: Lacia
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Each boat comes every 1152 seconds/8 game hours, 4 hour offset between Selbina and Aht Urghan
    -- Original timer: local timer = 1152 - ((os.time() - 1009810584)%1152)
    local timer = 1152 - ((os.time() - 1009810802)%1152)
    local destination = 0 -- Selbina, set to 1 for Al Zhabi
    local direction = 0 -- Arrive, 1 for depart
    local waiting = 216 -- Offset for Selbina

    -- Next ferry is Al Zhabi for higher values.
    if timer >= 576 then
        destination = 1
        timer = timer - 576
        waiting = 193
    end

    -- Logic to manipulate cutscene results.
    if timer <= waiting then
        direction = 1 -- Ship arrived, switch dialog from "arrive" to "depart"
    else
        timer = timer - waiting -- Ship hasn't arrived, subtract waiting time to get time to arrival
    end

    player:startEvent(333, timer, direction, 0, destination) -- timer arriving/departing ??? destination
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
