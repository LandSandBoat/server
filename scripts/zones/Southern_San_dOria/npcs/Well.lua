-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Well
-- Involved in Quest: Grave Concerns
-- !pos -129 -6 92 230
-------------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.GRAVE_CONCERNS) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(547, 1) and trade:getItemCount() == 1) then
            player:tradeComplete()
            player:addItem(567)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 567) -- Tomb Waterskin
        end
    end

end

function onTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
