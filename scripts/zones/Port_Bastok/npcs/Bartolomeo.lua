-----------------------------------
-- Area: Port Bastok
--  NPC: Bartolomeo
-- Standard Info NPC
-- Involved in Quest: Welcome to Bastok
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WelcometoBastok = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.WELCOME_TO_BASTOK)

    if (WelcometoBastok == QUEST_ACCEPTED and player:getCharVar("WelcometoBastok_Event") ~= 1 and player:getEquipID(tpz.slot.SUB) == 12415) then -- Shell Shield
        player:startEvent(52)
    else
        player:messageSpecial(ID.text.BARTHOLOMEO_DIALOG)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 52 and player:getQuestStatus(BASTOK, tpz.quest.id.bastok.WELCOME_TO_BASTOK) == QUEST_ACCEPTED) then
        player:setCharVar("WelcometoBastok_Event", 1)
    end

end
