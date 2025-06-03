-----------------------------------
-- Area: Port Windurst
--  NPC: Three of Clubs
-- !pos -7.238 -5 106.982 240
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatWindurst = player:getCharVar('WildcatWindurst')

    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 18)
    then
        player:startEvent(625)
    else
        player:startEvent(222)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 625 then
        player:setCharVar('WildcatWindurst', utils.mask.setBit(player:getCharVar('WildcatWindurst'), 18, true))
    end
end

return entity
