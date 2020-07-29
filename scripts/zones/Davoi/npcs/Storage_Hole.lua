-----------------------------------
-- Area: Davoi
--  NPC: Storage Hole
-- Involved in Quest: The Crimson Trial
-- !pos -51 4 -217 149
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Davoi/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_CRIMSON_TRIAL) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(1103, 1) and trade:getItemCount() == 1) then
            player:tradeComplete()
            player:addKeyItem(tpz.ki.ORCISH_DRIED_FOOD)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ORCISH_DRIED_FOOD)
        end
    end

end

function onTrigger(player, npc)

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_CRIMSON_TRIAL) == QUEST_ACCEPTED) then
        player:messageSpecial(ID.text.AN_ORCISH_STORAGE_HOLE)
    else
        player:messageSpecial(ID.text.YOU_SEE_NOTHING)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
