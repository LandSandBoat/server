-----------------------------------
-- Area: Port Windurst
--  NPC: Three of Clubs
-- Type: Standard NPC
-- !pos -7.238 -5 106.982 240
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatWindurst = player:getCharVar("WildcatWindurst")

    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatWindurst, 18) == false) then
        player:startEvent(625)
    else
        player:startEvent(222)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 625) then
        player:setMaskBit(player:getCharVar("WildcatWindurst"), "WildcatWindurst", 18, true)
    end

end
