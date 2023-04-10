-----------------------------------
-- Area: Tahrongi Canyon
--  NPC: Tahrongi Cacti
-- Involved in Quest: Say It with Flowers
-- !pos -308.721 7.477 264.454
-----------------------------------
local ID = require("scripts/zones/Tahrongi_Canyon/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SAY_IT_WITH_FLOWERS) > QUEST_AVAILABLE and
        player:getCharVar("FLOWER_PROGRESS") == 3
    then
        if player:getFreeSlotsCount() > 0 and not player:hasItem(950) then
            player:addItem(950) -- Tahrongi Cactus
            player:messageSpecial(ID.text.BUD_BREAKS_OFF, 0, 950)
        else
            player:messageSpecial(ID.text.CANT_TAKE_ANY_MORE)
        end
    else
        player:messageSpecial(ID.text.POISONOUS_LOOKING_BUDS)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
