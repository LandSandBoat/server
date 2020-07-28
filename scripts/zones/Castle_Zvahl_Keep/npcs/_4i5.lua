-----------------------------------
-- Area: Castle Zvahl Keep
--  NPC: Ore door
-- Involved In Quest: Recollections
-- !pos -14 0 69 162
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Castle_Zvahl_Keep/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.RECOLLECTIONS) == QUEST_ACCEPTED and player:getCharVar("recollectionsQuest") == 2) then
        if (trade:hasItemQty(1106, 1) and trade:getItemCount() == 1) then
            player:startEvent(8, 1106)
        end
    end

end

function onTrigger(player, npc)
    player:startEvent(9)
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 8) then
        player:tradeComplete()
        player:setCharVar("recollectionsQuest", 3)
        player:addKeyItem(tpz.ki.FOE_FINDER_MK_I)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.FOE_FINDER_MK_I)
    end

end
