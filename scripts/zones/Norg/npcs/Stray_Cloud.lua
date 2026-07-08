-----------------------------------
-- Area: Norg
--  NPC: Stray Cloud
-- Starts and Ends Quest: An Undying Pledge
-- !pos-20.617, 1.097, -29.165, 133
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local anUndyingPledge = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.AN_UNDYING_PLEDGE)

    if
        anUndyingPledge == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.NORG) >= 4
    then
        player:startEvent(225) -- Start quest
    elseif
        anUndyingPledge == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.CALIGINOUS_BLADE)
    then
        player:startEvent(227) -- Quest Finish
    elseif
        anUndyingPledge == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('anUndyingPledgeCS') == 1
    then
        player:startEvent(228) -- Extra Dialogue
    elseif
        anUndyingPledge == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('anUndyingPledgeCS') == 2
    then
        player:startEvent(229) -- Extra Dialogue
    elseif anUndyingPledge == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(230)
    else
        player:startEvent(231) -- Standard Conversation
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 225 then
        player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.AN_UNDYING_PLEDGE)
        player:setCharVar('anUndyingPledgeCS', 1)
    elseif
        csid == 227 and
        npcUtil.completeQuest(player, xi.questLog.OUTLANDS, xi.quest.id.outlands.AN_UNDYING_PLEDGE, {
            item = xi.item.LIGHT_BUCKLER,
            fameArea = xi.fameArea.NORG,
            fame = 50,
            var = 'anUndyingPledgeCS',
        })
    then
        player:delKeyItem(xi.ki.CALIGINOUS_BLADE)
    end
end

return entity
