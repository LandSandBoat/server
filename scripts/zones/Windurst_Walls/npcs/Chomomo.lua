-----------------------------------
-- Area: Windurst Walls
--  NPC: Chomomo
-- Type: Standard NPC
-- !pos -1.262 -11 290.224 239
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatWindurst = player:getCharVar("WildcatWindurst")

    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatWindurst, 8) == false) then
        player:startEvent(499)
    else
        player:startEvent(325)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 499) then
        player:setMaskBit(player:getCharVar("WildcatWindurst"), "WildcatWindurst", 8, true)
    end

end
