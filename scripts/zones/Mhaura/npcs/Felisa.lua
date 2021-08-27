-----------------------------------
-- Area: Mhaura
--  NPC: Felisa
-- Admits players to the dock in Mhaura.
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getZPos() > 38.5) then
        if
            player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.HIS_NAME_IS_VALGEIR) == QUEST_ACCEPTED and
            player:hasKeyItem(xi.ki.ARAGONEU_PIZZA)
        then
            player:startEvent(230)
        else
            player:startEvent(221, player:getGil(), 100)
        end
    else
        player:startEvent(235)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 221 and option == 333) then
        player:delGil(100)
    end

end

return entity
