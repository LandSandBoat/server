-----------------------------------
-- Area: Bastok Markets
--   NPC: Umberto
-- Type: Quest NPC
-- Involved in Quest: Too Many Chefs
-- !pos -56.896 -5 -134.267 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCharVar("TOO_MANY_CHEFS") == 5) then -- end Quest Too Many Chefs
        player:startEvent(473)
    else
        player:startEvent(411)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 473) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 5674)
        else
            player:addItem(5674)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 5674)
            player:addFame(BASTOK, 30)
            player:setCharVar("TOO_MANY_CHEFS", 0)
            player:completeQuest(BASTOK, tpz.quest.id.bastok.TOO_MANY_CHEFS)
        end
    end
end
