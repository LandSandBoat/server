-----------------------------------
-- Area: Norg
--  NPC: Stray Cloud
-- Starts and Ends Quest: An Undying Pledge
-- !pos-20.617, 1.097, -29.165, 133
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local anUndyingPledge = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.AN_UNDYING_PLEDGE)

    if
        anUndyingPledge == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.NORG) >= 4
    then
        player:startEvent(225) -- Start quest
    elseif
        anUndyingPledge == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.CALIGINOUS_BLADE)
    then
        player:startEvent(227) -- Quest Finish
    elseif
        anUndyingPledge == QUEST_ACCEPTED and
        player:getCharVar("anUndyingPledgeCS") == 1
    then
        player:startEvent(228) -- Extra Dialogue
    elseif
        anUndyingPledge == QUEST_ACCEPTED and
        player:getCharVar("anUndyingPledgeCS") == 2
    then
        player:startEvent(229) -- Extra Dialogue
    elseif anUndyingPledge == QUEST_COMPLETED then
        player:startEvent(230)
    else
        player:startEvent(231) -- Standard Conversation
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 225 then
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.AN_UNDYING_PLEDGE)
        player:setCharVar("anUndyingPledgeCS", 1)
    elseif
        csid == 227 and
        npcUtil.completeQuest(player, xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.AN_UNDYING_PLEDGE, {
            item = 12375,
            fameArea = xi.quest.fame_area.NORG,
            fame = 50,
            var = "anUndyingPledgeCS",
        })
    then
        player:delKeyItem(xi.ki.CALIGINOUS_BLADE)
    end
end

return entity
