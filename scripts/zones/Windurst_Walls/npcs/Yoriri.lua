-----------------------------------
-- Area: Windurst Walls
--  NPC: Yoriri
-- Type: Standard NPC
-- !pos 65.268 -8.5 -58.309 239
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatWindurst = player:getCharVar("WildcatWindurst")

    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatWindurst, 5) == false) then
        player:startEvent(496)
    else
        player:startEvent(313)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 496) then
        player:setMaskBit(player:getCharVar("WildcatWindurst"), "WildcatWindurst", 5, true)
    end

end
