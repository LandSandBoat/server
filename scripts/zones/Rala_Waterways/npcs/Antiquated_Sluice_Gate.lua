-----------------------------------
-- Area: Rala Waterways (258)
--  NPC: Antiquated_Sluice_Gate
-- !pos -529.361 -7.000 59.988 258
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(5511, 0, 8)
end

entity.onEventUpdate = function(player, csid, option)
    -- Waiting for instance
    if csid == 5511 then
        if option == 843 then
            player:updateEvent(258, 8, 0, 1, 0, 0, 0, 1)
        elseif option == 4939 then
            if player:getLocalVar("Rala_Waterways_U_Entry") == 0 then
                player:updateEvent(258, 8, 0, 1, 0, 0, 0, 11)
                player:setLocalVar("Rala_Waterways_U_Entry", 1)
            end
        end
    end
end

entity.onEventFinish = function(player, csid, option)
end

return entity
