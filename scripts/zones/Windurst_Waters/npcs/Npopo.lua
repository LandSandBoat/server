-----------------------------------
-- Area: Windurst Waters
--  NPC: Npopo
-- Type: Standard NPC
-- !pos -35.464 -5.999 239.120 238
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatWindurst = player:getCharVar("WildcatWindurst")

    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatWindurst, 10) == false) then
        player:startEvent(936)
    else
        player:startEvent(269)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 936) then
        player:setMaskBit(player:getCharVar("WildcatWindurst"), "WildcatWindurst", 10, true)
    end

end
