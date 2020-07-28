-----------------------------------
-- Area: La Theine Plateau
--  NPC: ??? (qm2)
--  Involved in Quest: HITTING_THE_MARQUISATE (THF AF3)
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/settings")
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    local hittingTheMarquisateNanaaCS = player:getCharVar("hittingTheMarquisateNanaaCS")

    if (trade:hasItemQty(605, 1) and trade:getItemCount() == 1) then -- Trade pickaxe
        if (hittingTheMarquisateNanaaCS == 1) then
            player:startEvent(119)
        end
    end
end

function onTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 119) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 14094)
        else
        player:addItem(14094)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 14094)
        player:tradeComplete()
        player:completeQuest(WINDURST, tpz.quest.id.windurst.HITTING_THE_MARQUISATE)
        player:addTitle(tpz.title.PARAGON_OF_THIEF_EXCELLENCE)
        player:setCharVar("hittingTheMarquisateNanaaCS", 0)
        player:delKeyItem(tpz.ki.CAT_BURGLARS_NOTE)
        end
    end
end
