-----------------------------------
-- Area: Windurst Woods
--  NPC: Wani Casdohry
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local TwinstoneBonding = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.TWINSTONE_BONDING)

    if TwinstoneBonding == QUEST_COMPLETED then
        player:startEvent(492, 0, 13360)
    elseif TwinstoneBonding == QUEST_ACCEPTED then
        player:startEvent(489, 0, 13360)
    else
        player:startEvent(425)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
