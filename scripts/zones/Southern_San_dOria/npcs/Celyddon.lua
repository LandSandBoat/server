-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Celyddon
--  General Info NPC
-- !pos -129 -6 90 230
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local ASquiresTest = player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.A_SQUIRE_S_TEST)

    if ASquiresTest == (QUEST_AVAILABLE) then
        player:startEvent(618) -- im looking for the examiner
    elseif ASquiresTest == (QUEST_ACCEPTED) then
        player:startEvent(619) -- i found the examiner but said i had to use sword
    else
        player:startEvent(620) -- says i needs a revival tree root
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
