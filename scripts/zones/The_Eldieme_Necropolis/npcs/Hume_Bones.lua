-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: Hume Bones
-- Involved in Quests: Blue Ribbon Blues
-- !pos 299 0.1 19 195
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLUE_RIBBON_BLUES) == QUEST_ACCEPTED and
        player:getCharVar("BlueRibbonBluesProg") >= 3 and
        player:getCharVar("Lich_C_Magnus_Died") == 0 and
        npcUtil.tradeHas(trade, xi.items.PURPLE_RIBBON) and
        npcUtil.popFromQM(player, npc, ID.mob.LICH_C_MAGNUS, {hide = 0})
    then
        player:messageSpecial(ID.text.RETURN_RIBBON_TO_HER)
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("Lich_C_Magnus_Died") == 1 and not player:hasItem(xi.items.BLUE_RIBBON) then
        if npcUtil.giveItem(player, xi.items.BLUE_RIBBON) then
            player:setCharVar("Lich_C_Magnus_Died", 0)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
