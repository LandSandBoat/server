-----------------------------------
-- Area: Norg
--  NPC: Aeka
-- Involved in Quest: Forge Your Destiny
-- !pos 4 0 -4 252
-----------------------------------
local ID = require("scripts/zones/Norg/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.items.CHUNK_OF_DARKSTEEL_ORE) and utils.mask.getBit(player:getCharVar("ForgeYourDestiny_Event"), 0) then
        player:startEvent(47, 0, xi.items.LUMP_OF_ORIENTAL_STEEL, xi.items.CHUNK_OF_DARKSTEEL_ORE) -- Oriental Steel, Darksteel Ore
    end
end

entity.onTrigger = function(player, npc)
    local forgeYourDestiny = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.FORGE_YOUR_DESTINY)
    local swordTimer = player:getCharVar("ForgeYourDestiny_timer")

    if forgeYourDestiny == QUEST_ACCEPTED and swordTimer == 0 then
        if player:hasItem(xi.items.LUMP_OF_BOMB_STEEL) then
            player:startEvent(48, xi.items.LUMP_OF_BOMB_STEEL) -- Bomb Steel
        elseif not player:hasItem(xi.items.LUMP_OF_ORIENTAL_STEEL) then
            if not utils.mask.getBit(player:getCharVar("ForgeYourDestiny_Event"), 0) then
                player:startEvent(44, xi.items.LUMP_OF_BOMB_STEEL, xi.items.LUMP_OF_ORIENTAL_STEEL) -- Bomb Steel, Oriental Steel
            else
                player:startEvent(46, 0, xi.items.LUMP_OF_ORIENTAL_STEEL, xi.items.CHUNK_OF_DARKSTEEL_ORE) -- Oriental Steel, Darksteel Ore
            end
        else
            player:startEvent(45, xi.items.LUMP_OF_BOMB_STEEL, xi.items.LUMP_OF_ORIENTAL_STEEL) -- Bomb Steel, Oriental Steel
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

    if csid == 44 and npcUtil.giveItem(player, xi.items.LUMP_OF_ORIENTAL_STEEL) then
        player:setCharVar("ForgeYourDestiny_Event", utils.mask.setBit(player:getCharVar("ForgeYourDestiny_Event"), 0, true))
    elseif csid == 47 and npcUtil.giveItem(player, xi.items.LUMP_OF_ORIENTAL_STEEL) then
        player:confirmTrade()
    end

end

return entity
