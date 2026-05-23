-----------------------------------
-- Area: Abyssea-La Theine
--  NPC: Curilla
-- Starts and Finishes Quest: An Eye for Revenge
-- !pos: -467.7 -3.5 -769.5 132
-----------------------------------
---@type TNpcEntity

local entity = {}

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.AN_EYE_FOR_REVENGE) ~= xi.questStatus.QUEST_COMPLETED then
        if player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.LOST_MEMORIES) ~= xi.questStatus.QUEST_COMPLETED then
            player:startEvent(189) -- Need to complete the quest "Lost Memories" (See Halver NPC)
        elseif player:hasKeyItem(xi.ki.VIAL_OF_LAMBENT_POTION) then
            player:startEvent(190) -- Begin quest "An Eye for Revenge"
        elseif player:hasKeyItem(xi.ki.LUGARHOOS_EYEBALL) then
            player:startEvent(192) -- Complete quest "An Eye for Revenge"
        else
            player:startEvent(191) -- Quest accepted but not yet completed
        end
    else
        player:startEvent(193) -- Quest has already been completed
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 190 then
        player:delKeyItem(xi.ki.VIAL_OF_LAMBENT_POTION)
        player:addQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.AN_EYE_FOR_REVENGE)
    elseif csid == 192 then
        player:delKeyItem(xi.ki.LUGARHOOS_EYEBALL)
        player:addCurrency('cruor', 800)
        player:printToPlayer('You received 800 cruor from Curilla') --TODO implement cruor in npc_utils
        player:printToPlayer('You received the Scarlet Abyssite of Furtherance') --TODO fix Abyssea messages so this section can be removed.
        npcUtil.giveKeyItem(player, xi.ki.SCARLET_ABYSSITE_OF_FURTHERANCE)
        player:completeQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.AN_EYE_FOR_REVENGE)
    end
end

return entity
