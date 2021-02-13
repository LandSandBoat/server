-----------------------------------
-- Area: Bastok Markets
--  NPC: Ken
-- Type: Quest NPC
-- !pos -340.857 -11.003 -149.008 235
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local WildcatBastok = player:getCharVar("WildcatBastok")

    if (player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatBastok, 13)) then
        player:startEvent(432)
    else
        player:startEvent(361)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 432) then
        player:setCharVar("WildcatBastok", utils.mask.setBit(player:getCharVar("WildcatBastok"), 13, true))
    end

end

return entity
