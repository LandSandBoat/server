-----------------------------------
-- Area: Port Windurst
--  NPC: Yaman-Hachuman
-- Type: Standard NPC
--  Involved in Quests: Wonder Wands
-- !pos -101.209 -4.25 110.886 240
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WonderWands = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.WONDER_WANDS)
    local WildcatWindurst = player:getCharVar("WildcatWindurst")

    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatWindurst, 16) == false) then
        player:startEvent(624)
    elseif (WonderWands == QUEST_ACCEPTED) then
        player:startEvent(256, 0, 0, 0, 17061)
    elseif (WonderWands == QUEST_COMPLETED) then
        player:startEvent(268)
    else
        player:startEvent(233)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 624) then
        player:setMaskBit(player:getCharVar("WildcatWindurst"), "WildcatWindurst", 16, true)
    end

end
