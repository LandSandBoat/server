-----------------------------------
-- Area: The Sanctuary of Zitah
--  NPC: ???
-- Finishes Quest: Lovers in the Dusk
-- !zone 121
-----------------------------------
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/world")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVERS_IN_THE_DUSK) == QUEST_ACCEPTED and
        VanadielTOTD() == xi.time.DUSK
    then
        player:startEvent(204)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 204 then
        npcUtil.completeQuest(player, xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVERS_IN_THE_DUSK, { item = 17346, fame = 120 })
    end
end

return entity
