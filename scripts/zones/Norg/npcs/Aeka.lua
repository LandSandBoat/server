-----------------------------------
-- Area: Norg
--  NPC: Aeka
-- Involved in Quest: Forge Your Destiny
-- !pos 4 0 -4 252
-----------------------------------
local ID = require("scripts/zones/Norg/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 645) and utils.mask.getBit(player:getCharVar("ForgeYourDestiny_Event"), 0) then
        player:startEvent(47, 0, 1151, 645) -- Oriental Steel, Darksteel Ore
    end
end

entity.onTrigger = function(player, npc)
    local forgeYourDestiny = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.FORGE_YOUR_DESTINY)
    local swordTimer = player:getCharVar("ForgeYourDestiny_timer")

    if forgeYourDestiny == QUEST_ACCEPTED and swordTimer == 0 then
        if player:hasItem(1152) then
            player:startEvent(48, 1152) -- Bomb Steel
        elseif not player:hasItem(1151) then
            if not utils.mask.getBit(player:getCharVar("ForgeYourDestiny_Event"), 0) then
                player:startEvent(44, 1152, 1151) -- Bomb Steel, Oriental Steel
            else
                player:startEvent(46, 0, 1151, 645) -- Oriental Steel, Darksteel Ore
            end
        else
            player:startEvent(45, 1152, 1151) -- Bomb Steel, Oriental Steel
        end
    elseif swordTimer > 0 then
        player:startEvent(50)
    else
        player:startEvent(120)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    local questItem = player:getCharVar("ForgeYourDestiny_Event")

    if csid == 44 and npcUtil.giveItem(player, 1151) then
        player:setCharVar("ForgeYourDestiny_Event", utils.mask.setBit(player:getCharVar("ForgeYourDestiny_Event"), 0, true))
    elseif csid == 47 and npcUtil.giveItem(player, 1151) then
        player:confirmTrade()
    end

end

return entity
