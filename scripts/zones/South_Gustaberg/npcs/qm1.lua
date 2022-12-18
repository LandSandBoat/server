-----------------------------------
-- Area: South Gustaberg
--  NPC: qm1 (???)
-- Involved in Quest: The Cold Light of Day
-- !pos 744 0 -671 107
-----------------------------------
local ID = require("scripts/zones/South_Gustaberg/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        (npcUtil.tradeHas(trade, 4514) or npcUtil.tradeHas(trade, 5793)) and
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_COLD_LIGHT_OF_DAY) >= QUEST_ACCEPTED
    then
        npcUtil.popFromQM(player, npc, ID.mob.BUBBLY_BERNIE, { hide = 1 })
        player:confirmTrade()
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.MONSTER_TRACKS)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
