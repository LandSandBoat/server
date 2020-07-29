-----------------------------------
-- Area: FeiYin
--  NPC: Dry Fountain
-- Involved In Quest: Peace for the Spirit
-- !pos -17 -16 71 204
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
local ID = require("scripts/zones/FeiYin/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.PEACE_FOR_THE_SPIRIT) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(1093, 1) and trade:getItemCount() == 1) then -- Trade Antique Coin
            player:startEvent(17)
        end
    end

end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 17) then
        player:tradeComplete()
        player:setCharVar("peaceForTheSpiritCS", 2)
    end

end
