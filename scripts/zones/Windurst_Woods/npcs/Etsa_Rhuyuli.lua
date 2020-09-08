-----------------------------------
-- Area: Windurst Woods
--  NPC: Etsa Rhuyuli
-- Type: Standard NPC
-- !pos 62.482 -8.499 -139.836 241
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local WildcatWindurst = player:getCharVar("WildcatWindurst")

    if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not player:getMaskBit(WildcatWindurst, 1) then
        player:startEvent(734)
    else
        player:startEvent(422)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 734 then
        player:setMaskBit(player:getCharVar("WildcatWindurst"), "WildcatWindurst", 1, true)
    end
end
