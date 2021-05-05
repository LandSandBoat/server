-----------------------------------
-- Area: Selbina
--  NPC: Valgeir
-- Involved in quests: "His Name is Valgeir", "Expertise", "The Basics"
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- THE BASICS
    if player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_BASICS) == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.MHAURAN_COUSCOUS) then
        player:startEvent(106)
    elseif player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_BASICS) == QUEST_COMPLETED and player:getCharVar("QuestTheBacisCommentary_var") == 1 then
        player:startEvent(107)

    -- STANDARD DIALOG
    else
        player:startEvent(140)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- THE BASICS
    if csid == 106 and npcUtil.giveItem(player, 4436) then
        player:setCharVar("QuestTheBacisCommentary_var", 1)
        player:delKeyItem(xi.ki.MHAURAN_COUSCOUS)
    elseif csid == 107 then
        player:setCharVar("QuestTheBacisCommentary_var", 0)
    end
end

return entity
