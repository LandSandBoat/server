-----------------------------------
-- Area: Western Adoulin
--  NPC: Jorin
-- Starts, Involved with, and Finishes Quest: 'The Old Man and the Harpoon'
-- !pos 92 32 152 256
-----------------------------------
local ID = zones[xi.zone.WESTERN_ADOULIN]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local tomath = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.THE_OLD_MAN_AND_THE_HARPOON)

    if tomath == xi.questStatus.QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.EXTRAVAGANT_HARPOON) then
            -- Finishing Quest: 'The Old Man and the Harpoon'
            player:startEvent(2542)
        else
            -- Dialgoue during Quest: 'The Old Man and the Harpoon'
            player:startEvent(2541)
        end
    elseif tomath == xi.questStatus.QUEST_AVAILABLE then
        -- Starts Quest: 'The Old Man and the Harpoon'
        player:startEvent(2540)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 2540 then
        -- Starting Quest: 'The Old Man and the Harpoon'
        player:addQuest(xi.questLog.ADOULIN, xi.quest.id.adoulin.THE_OLD_MAN_AND_THE_HARPOON)
        npcUtil.giveKeyItem(player, xi.ki.BROKEN_HARPOON)
    elseif csid == 2542 then
        -- Finishing Quest: 'The Old Man and the Harpoon'
        player:completeQuest(xi.questLog.ADOULIN, xi.quest.id.adoulin.THE_OLD_MAN_AND_THE_HARPOON)
        player:addExp(500 * xi.settings.main.EXP_RATE)
        player:addCurrency('bayld', 300 * xi.settings.main.BAYLD_RATE)
        player:messageSpecial(ID.text.BAYLD_OBTAINED, 300 * xi.settings.main.BAYLD_RATE)
        player:delKeyItem(xi.ki.EXTRAVAGANT_HARPOON)

        -- TODO: Verify fame value added
        player:addFame(xi.fameArea.ADOULIN, 30)
    end
end

return entity
