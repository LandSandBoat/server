-----------------------------------
-- Area: Davoi
--  NPC: ??? (qm1)
-- Involved in Quest: To Cure a Cough
-- !pos -115.830 -0.427 -184.289 149
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Davoi/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local toCureaCough = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.TO_CURE_A_COUGH)

    if (toCureaCough == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.THYME_MOSS) == false) then
        player:addKeyItem(tpz.ki.THYME_MOSS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.THYME_MOSS)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
