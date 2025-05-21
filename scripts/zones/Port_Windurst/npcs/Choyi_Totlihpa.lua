-----------------------------------
-- Area: Port Windurst
--  NPC: Choyi Totlihpa
-- !pos -58.927 -5.732 132.819 240
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatWindurst = player:getCharVar('WildcatWindurst')

    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 17)
    then
        player:startEvent(622)
    else
        player:startEvent(215)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 622 then
        player:setCharVar('WildcatWindurst', utils.mask.setBit(player:getCharVar('WildcatWindurst'), 17, true))
    end
end

return entity
