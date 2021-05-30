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

    if npcUtil.tradeHas(trade, {{xi.items.CHUNK_OF_GOLD_ORE, 2}, xi.items.CHUNK_OF_PLATINUM_ORE}) then
        player:startEvent(43, 0, 0, xi.items.CHUNK_OF_PLATINUM_ORE, xi.items.CHUNK_OF_GOLD_ORE) -- Platinum Ore, Gold Ore
    elseif
        theSacredKatana == QUEST_ACCEPTED and
        not player:hasItem(xi.items.MUMEITO) and
        npcUtil.tradeHas(trade, {{"gil", 30000}})
    then
        player:startEvent(145)
    end
end

entity.onTrigger = function(player, npc)
    local forgeYourDestiny = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.FORGE_YOUR_DESTINY)
    local swordTimer = player:getCharVar("ForgeYourDestiny_timer")
    local theSacredKatana = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_SACRED_KATANA)

    if forgeYourDestiny == QUEST_ACCEPTED and swordTimer == 0 then
        if player:hasItem(xi.items.SACRED_BRANCH) then
            player:startEvent(48, xi.items.SACRED_BRANCH) -- Sacred Branch
        elseif not player:hasItem(xi.items.SACRED_SPRIG) then
            if not utils.mask.getBit(player:getCharVar("ForgeYourDestiny_Event"), 1) then
                player:startEvent(40, xi.items.SACRED_BRANCH, xi.items.SACRED_SPRIG) -- Sacred Branch, Sacred Sprig
            else
                player:startEvent(42, 0, xi.items.SACRED_SPRIG, xi.items.CHUNK_OF_PLATINUM_ORE, xi.items.CHUNK_OF_GOLD_ORE) -- Platinum Ore, Gold Ore
            end
        else
            player:startEvent(41)
        end
    elseif theSacredKatana == QUEST_ACCEPTED and not player:hasItem(xi.items.MUMEITO) then
        player:startEvent(144)
    else
        player:startEvent(68)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 40 and npcUtil.giveItem(player, xi.items.SACRED_SPRIG) then
        player:setCharVar("ForgeYourDestiny_Event", utils.mask.setBit(player:getCharVar("ForgeYourDestiny_Event"), 1, true))
    elseif csid == 43 and npcUtil.giveItem(player, xi.items.SACRED_SPRIG) then
        player:confirmTrade()
    elseif csid == 145 and npcUtil.giveItem(player, xi.items.MUMEITO) then
        player:confirmTrade()
    end
end

return entity
