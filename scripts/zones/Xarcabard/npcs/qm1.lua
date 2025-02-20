-----------------------------------
-- Area: Xarcabard
--  NPC: qm1 (???)
-- Involved in Quests: The Three Magi
-- !pos -331 -29 -49 112
-----------------------------------
local ID = zones[xi.zone.XARCABARD]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_THREE_MAGI) == xi.questStatus.QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, xi.item.FADED_CRYSTAL) and
        not player:hasItem(xi.item.GLOWSTONE) and
        npcUtil.popFromQM(player, npc, ID.mob.CHAOS_ELEMENTAL)
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

return entity
