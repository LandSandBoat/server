-----------------------------------
-- Area: Kazham
--  NPC: Bhoyu Halpatacco
-- !pos -18 -4 -15 250
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local Z = player:getZPos()

    if (Z >= -11 and Z <= -6) then
        player:startEvent(67)
    elseif (player:getGil() >= 200) then
        player:startEvent(116, 0, 200)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 116) then
        local Z = player:getZPos()

        if (Z >= -10 and Z <= -6) then
            player:delGil(200)
        end
    end
end

return entity
