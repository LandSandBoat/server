-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Abquhbah
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local promotion = player:getCharVar("AssaultPromotion")
    local rank = 0

    if promotion <= 7 then
        rank = 1
    elseif promotion >= 8 and promotion <= 11 then
        rank = 2
    elseif promotion >= 12 and promotion <= 18 then
        rank = 3
    elseif promotion >= 19 then
        rank = 4
    end

    player:startEvent(255, rank)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
