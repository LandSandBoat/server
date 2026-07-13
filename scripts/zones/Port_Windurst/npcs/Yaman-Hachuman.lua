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

    if wonderWands == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(256, 0, 0, 0, 17061)
    elseif wonderWands == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(268)
    else
        player:startEvent(233)
    end
end

return entity
