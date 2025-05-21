-----------------------------------
-- Area: Windurst Walls (239)
--  NPC: Shantotto
-- !pos 122 -2 112 239
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatWindurst = player:getCharVar('WildcatWindurst')

    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 6)
    then
        player:startEvent(498)
    elseif
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CLASS_REUNION) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('ClassReunionProgress') == 3
    then
        player:startEvent(409) -- she mentions that Sunny-Pabonny left for San d'Oria
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 409 then
        player:setCharVar('ClassReunionProgress', 4)
    elseif csid == 498 then
        player:setCharVar('WildcatWindurst', utils.mask.setBit(player:getCharVar('WildcatWindurst'), 6, true))
    end
end

return entity
