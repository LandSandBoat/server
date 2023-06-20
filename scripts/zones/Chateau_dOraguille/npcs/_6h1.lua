-----------------------------------
-- Area: Chateau d'Oraguille
-- Door: Prince Regent's Rm
-- Starts and Finishes Quest: Prelude of Black and White (Start), Pieuje's Decision (Start)
-- !pos -37 -3 31 233
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local sandyQuests = xi.quest.id.sandoria
    local whmAf1 = player:getQuestStatus(xi.quest.log_id.SANDORIA, sandyQuests.MESSENGER_FROM_BEYOND)
    local whmAf2 = player:getQuestStatus(xi.quest.log_id.SANDORIA, sandyQuests.PRELUDE_OF_BLACK_AND_WHITE)
    local whmAf3 = player:getQuestStatus(xi.quest.log_id.SANDORIA, sandyQuests.PIEUJE_S_DECISION)

    -- WHM AF quests
    if
        player:getMainJob() == xi.job.WHM and
        player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL
    then
        if whmAf1 == QUEST_COMPLETED and whmAf2 == QUEST_AVAILABLE then
            player:startEvent(551) -- Start Quest "Prelude of Black and White"
        elseif whmAf2 == QUEST_COMPLETED and whmAf3 == QUEST_AVAILABLE then
            player:startEvent(552) -- Start Quest "Pieuje's Decision"
        end

    -- San d'Oria Rank 10 (new default)
    elseif
        player:getNation() == xi.nation.SANDORIA and
        player:getRank(player:getNation()) == 10
    then
        player:startEvent(73)

    -- Default dialogue
    else
        player:startEvent(523)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 551 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PRELUDE_OF_BLACK_AND_WHITE)
    elseif csid == 552 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PIEUJE_S_DECISION)
    end
end

return entity
