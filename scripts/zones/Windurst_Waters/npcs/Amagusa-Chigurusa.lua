-----------------------------------
-- Area: Windurst Waters
--  NPC: Amagusa-Chigurusa
-- Type: Standard NPC
-- !pos -28.746 -4.5 61.954 238
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatWindurst = player:getCharVar("WildcatWindurst")

    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and utils.mask.getBit(WildcatWindurst, 12) == false) then
        player:startEvent(937)
    else
        player:startEvent(562)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 937) then
        player:setCharVar("WildcatWindurst", utils.mask.setBit(player:getCharVar("WildcatWindurst"), 12, true))
    end

end
