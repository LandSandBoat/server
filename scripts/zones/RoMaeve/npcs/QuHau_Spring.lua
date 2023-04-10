-----------------------------------
-- QuHau_Spring
-- Area: Ro'Maeve
-----------------------------------
local ID = require("scripts/zones/RoMaeve/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local dmFirst  = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT)
    local dmRepeat = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT_REPEAT)
    local hour     = VanadielHour()

    if (hour >= 18 or hour < 6) and IsMoonFull() then
        if dmFirst == QUEST_ACCEPTED or dmRepeat == QUEST_ACCEPTED then -- allow for Ark Pentasphere on both first and repeat quests
            if npcUtil.tradeHasExactly(trade, { 1408, 917 }) then
                player:startEvent(7, 917, 1408) -- Ark Pentasphere Trade
            elseif
                dmRepeat == QUEST_ACCEPTED and
                npcUtil.tradeHasExactly(trade, 1261) and
                not player:hasKeyItem(xi.ki.MOONLIGHT_ORE)
            then
                player:startEvent(8) -- Moonlight Ore trade
            end
        end
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 7 then
        if npcUtil.giveItem(player, 1550) then
            player:confirmTrade()
        end
    elseif csid == 8 then
        player:tradeComplete()
        player:addKeyItem(xi.ki.MOONLIGHT_ORE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MOONLIGHT_ORE)
    end
end

return entity
