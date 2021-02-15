-----------------------------------
-- Area: Norg
--  NPC: Ranemaud
-- Involved in Quest: Forge Your Destiny, The Sacred Katana
-- !pos 15 0 23 252
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local theSacredKatana = player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.THE_SACRED_KATANA)

    if npcUtil.tradeHas(trade, {{737, 2}, 738}) then
        player:startEvent(43, 0, 0, 738, 737) -- Platinum Ore, Gold Ore
    elseif
        theSacredKatana == QUEST_ACCEPTED and
        not player:hasItem(17809) and
        npcUtil.tradeHas(trade, {{"gil", 30000}})
    then
        player:startEvent(145)
    end
end

entity.onTrigger = function(player, npc)
    local forgeYourDestiny = player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.FORGE_YOUR_DESTINY)
    local swordTimer = player:getCharVar("ForgeYourDestiny_timer")
    local theSacredKatana = player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.THE_SACRED_KATANA)

    if forgeYourDestiny == QUEST_ACCEPTED and swordTimer == 0 then
        if player:hasItem(1153) then
            player:startEvent(48, 1153) -- Sacred Branch
        elseif not player:hasItem(1198) then
            if not utils.mask.getBit(player:getCharVar("ForgeYourDestiny_Event"), 1) then
                player:startEvent(40, 1153, 1198) -- Sacred Branch, Sacred Sprig
            else
                player:startEvent(42, 0, 1198, 738, 737) -- Platinum Ore, Gold Ore
            end
        else
            player:startEvent(41)
        end
    elseif theSacredKatana == QUEST_ACCEPTED and not player:hasItem(17809) then
        player:startEvent(144)
    else
        player:startEvent(68)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 40 and npcUtil.giveItem(player, 1198) then
        player:setCharVar("ForgeYourDestiny_Event", utils.mask.setBit(player:getCharVar("ForgeYourDestiny_Event"), 1, true))
    elseif csid == 43 and npcUtil.giveItem(player, 1198) then
        player:confirmTrade()
    elseif csid == 145 and npcUtil.giveItem(player, 17809) then
        player:confirmTrade()
    end
end

return entity
