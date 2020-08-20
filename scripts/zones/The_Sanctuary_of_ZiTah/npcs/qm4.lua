-----------------------------------
-- Area: The Sanctuary of Zitah
--  NPC: ???
-- Finishes Quest: Lovers in the Dusk
-- !zone 121
-----------------------------------
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/weather")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getQuestStatus(BASTOK, tpz.quest.id.bastok.LOVERS_IN_THE_DUSK) == QUEST_ACCEPTED and VanadielTOTD() == tpz.time.DUSK then
        player:startEvent(204)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 204 then
        npcUtil.completeQuest(player, BASTOK, tpz.quest.id.bastok.LOVERS_IN_THE_DUSK, {item = 17346, fame = 120})
    end
end
