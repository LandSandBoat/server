-----------------------------------
-- Area: Windurst Walls
--  Location: X:-92  Y:-9  Z:107
--  NPC: Rutango-Botango
--  Involved in Quest: To Bee or Not to Bee?
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local toBee = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TO_BEE_OR_NOT_TO_BEE)
    local toBeeOrNotStatus = player:getCharVar('ToBeeOrNot_var')

    if toBeeOrNotStatus == 10 then
        player:startEvent(65) -- During Too Bee quest before honey given to Zayhi:  'Oh Crumb...lost his voice'
    elseif toBee == xi.questStatus.QUEST_ACCEPTED and toBeeOrNotStatus > 0 then
        player:startEvent(71) -- During Too Bee quest after some honey was given to Zayhi: 'lap up more honey'
    elseif toBee == xi.questStatus.QUEST_COMPLETED and player:needToZone() then
        player:startEvent(76) -- After Too Bee quest but before zone: 'master let me speak for you'
    else
        player:startEvent(297) -- Standard Conversation
    end
end

-- CS/Event ID List for NPC
-- *Rutango-Botango    CS 443 - player:startEvent(443) -- Long Star Sybil CS
-- Rutango-Botango    CS 297 - player:startEvent(297) -- Standard Conversation
-- *Rutango-Botango    CS 64 - player:startEvent(64) -- Zayhi Coughing
-- Rutango-Botango    CS 65 - player:startEvent(65) -- During Too Bee quest before honey given to Zayhi:  "Oh Crumb...lost his voice"
-- Rutango-Botango    CS 71 - player:startEvent(71) -- During Too Bee quest after some honey was given to Zayhi: "lap up more honey"
-- *Rutango-Botango    CS 75 - player:startEvent(75) -- Combo CS: During Too Bee quest, kicked off from Zayhi
-- Rutango-Botango    CS 76 - player:startEvent(76) -- After Too Bee quest but before zone: "master let me speak for you"

return entity
