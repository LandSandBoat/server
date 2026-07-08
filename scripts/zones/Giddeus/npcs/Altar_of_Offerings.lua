-----------------------------------
-- Area: Giddeus
--  NPC: Alter of Offerings
-- Involved in Quest: A Crisis in the Making
-- !pos -137 17 177 145
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local crisisstatus = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.A_CRISIS_IN_THE_MAKING)
    if crisisstatus >= 1 and player:getCharVar('QuestCrisisMaking_var') == 1 then
        player:startEvent(53) -- A Crisis in the Making: Receive Offering
    else
        player:startEvent(60) -- Standard Message
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 53 and option == 1 then
        npcUtil.giveKeyItem(player, xi.ki.OFF_OFFERING)
        player:setCharVar('QuestCrisisMaking_var', 2)
    end
end

return entity
