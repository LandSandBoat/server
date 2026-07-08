-----------------------------------
-- Area: Port Windurst
--  NPC: Yaman-Hachuman
--  Involved in Quests: Wonder Wands
-- !pos -101.209 -4.25 110.886 240
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wonderWands = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.WONDER_WANDS)
    local wildcatWindurst = player:getCharVar('WildcatWindurst')

    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 16)
    then
        player:startEvent(624)
    elseif wonderWands == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(256, 0, 0, 0, 17061)
    elseif wonderWands == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(268)
    else
        player:startEvent(233)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 624 then
        player:setCharVar('WildcatWindurst', utils.mask.setBit(player:getCharVar('WildcatWindurst'), 16, true))
    end
end

return entity
