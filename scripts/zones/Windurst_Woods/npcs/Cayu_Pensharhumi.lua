-----------------------------------
-- Area: Windurst Woods
--  NPC: Cayu Pensharhumi
-- Type: Standard NPC
-- !pos 39.437 -0.91 -40.808 241
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local WildcatWindurst = player:getCharVar("WildcatWindurst")

    if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not player:getMaskBit(WildcatWindurst, 2) then
        player:startEvent(733)
    else
        player:startEvent(259)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 733 then
        player:setMaskBit(player:getCharVar("WildcatWindurst"), "WildcatWindurst", 2, true)
    end
end
