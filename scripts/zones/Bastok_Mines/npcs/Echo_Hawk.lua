-----------------------------------
-- Area: Bastok Mines
--  NPC: Echo Hawk
-- Standard Info NPC
-- Involved in Quest: The Siren's Tear
-- !pos -0.965 5.999 -15.567 234
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local SirensTear = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_SIREN_S_TEAR)

    local WildcatBastok = player:getCharVar("WildcatBastok")

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatBastok, 17) == false) then
        player:startEvent(505)
    elseif (SirensTear == QUEST_AVAILABLE) then
        player:startEvent(5)
    else
        player:startEvent(13)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 505) then
        player:setMaskBit(player:getCharVar("WildcatBastok"), "WildcatBastok", 17, true)
    end

end
