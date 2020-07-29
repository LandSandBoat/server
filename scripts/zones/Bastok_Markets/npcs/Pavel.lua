-----------------------------------
-- Area: Bastok Markets
--  NPC: Pavel
-- Involved in Quest: Stamp Hunt
-- !pos -349.798 -10.002 -181.296 235
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local WildcatBastok = player:getCharVar("WildcatBastok")
    local StampHunt = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.STAMP_HUNT)

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatBastok, 14) == false) then
        player:startEvent(431)
    elseif (StampHunt == QUEST_ACCEPTED and player:getMaskBit(player:getCharVar("StampHunt_Mask"), 2) == false) then
        player:startEvent(227)
    else
        player:startEvent(128)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 431) then
        player:setMaskBit(player:getCharVar("WildcatBastok"), "WildcatBastok", 14, true)
    elseif (csid == 227) then
        player:setMaskBit(player:getCharVar("StampHunt_Mask"), "StampHunt_Mask", 2, true)
    end

end
