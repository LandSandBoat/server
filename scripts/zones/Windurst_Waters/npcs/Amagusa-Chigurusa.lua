-----------------------------------
-- Area: Windurst Waters
--  NPC: Amagusa-Chigurusa
-- Type: Standard NPC
-- !pos -28.746 -4.5 61.954 238
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local WildcatWindurst = player:getCharVar("WildcatWindurst")

    if (player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatWindurst, 12)) then
        player:startEvent(937)
    else
        player:startEvent(562)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 937) then
        player:setCharVar("WildcatWindurst", utils.mask.setBit(player:getCharVar("WildcatWindurst"), 12, true))
    end

end

return entity
