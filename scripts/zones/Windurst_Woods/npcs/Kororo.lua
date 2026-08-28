-----------------------------------
-- Area: Windurst Woods
--  NPC: Kororo
-- !pos -11.883 -2.750 5.508 241
-- Involved in Quests: A Greeting Cardian, Lost Chick
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local c2000 = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_ALL_NEW_C_2000)
    local lpb   = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LEGENDARY_PLAN_B)

    if c2000 == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(291)

    -- Might be Legendary Plan B, most likely Lost Chick related.
    -- only activates before LPB completes so leaving it in as is for now
    elseif lpb == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(312, 0, 529, 940, 858)
    end
end

return entity
