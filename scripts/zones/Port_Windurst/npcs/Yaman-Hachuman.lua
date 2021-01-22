-----------------------------------
-- Area: Port Windurst
--  NPC: Yaman-Hachuman
-- Type: Standard NPC
--  Involved in Quests: Wonder Wands
-- !pos -101.209 -4.25 110.886 240
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local WonderWands = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.WONDER_WANDS)
    local WildcatWindurst = player:getCharVar("WildcatWindurst")

    if (player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatWindurst, 16)) then
        player:startEvent(624)
    elseif (WonderWands == QUEST_ACCEPTED) then
        player:startEvent(256, 0, 0, 0, 17061)
    elseif (WonderWands == QUEST_COMPLETED) then
        player:startEvent(268)
    else
        player:startEvent(233)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 624) then
        player:setCharVar("WildcatWindurst", utils.mask.setBit(player:getCharVar("WildcatWindurst"), 16, true))
    end

end

return entity
