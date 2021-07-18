-----------------------------------
-- Area: Norg
--  NPC: Ranemaud
-- Involved in Quest: Forge Your Destiny, The Sacred Katana
-- !pos 15 0 23 252
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local theSacredKatana = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_SACRED_KATANA)

    if
        theSacredKatana == QUEST_ACCEPTED and
        not player:hasItem(xi.items.MUMEITO) and
        npcUtil.tradeHas(trade, {{"gil", 30000}})
    then
        player:startEvent(145)
    end
end

entity.onTrigger = function(player, npc)
    local theSacredKatana = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_SACRED_KATANA)

    if theSacredKatana == QUEST_ACCEPTED and not player:hasItem(xi.items.MUMEITO) then
        player:startEvent(144)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 145 and npcUtil.giveItem(player, xi.items.MUMEITO) then
        player:confirmTrade()
    end
end

return entity
