-----------------------------------
-- Area: The Sanctuary of ZiTah
--  NPC: qm2 (???)
-- Involved in Quest: Forge Your Destiny
-- !pos 639 -1 -151 121
-----------------------------------
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.FORGE_YOUR_DESTINY) == QUEST_ACCEPTED then
        if npcUtil.tradeHas(trade, 1021) and not player:hasItem(1153) and npcUtil.popFromQM(player, npc, ID.mob.GUARDIAN_TREANT, {hide = 0}) then
            player:confirmTrade()
        elseif npcUtil.tradeHas(trade, 1198) and player:getCharVar("ForgeYourDestiny_killed") == 1 and npcUtil.giveItem(player, 1153) then
            player:confirmTrade()
            player:setCharVar("ForgeYourDestiny_killed", 0)
        end
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.STURDY_BRANCH, 1021)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
