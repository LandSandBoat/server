-----------------------------------
-- QuHau_Spring
-- Area: Ro'Maeve
-----------------------------------
local ID = zones[xi.zone.ROMAEVE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local dmFirst  = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT)
    local dmRepeat = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT_REPEAT)
    local hour     = VanadielHour()

    if (hour >= 18 or hour < 6) and IsMoonFull() then
        if dmFirst == QUEST_ACCEPTED or dmRepeat == QUEST_ACCEPTED then -- allow for Ark Pentasphere on both first and repeat quests
            if npcUtil.tradeHasExactly(trade, { xi.item.BOTTLE_OF_ILLUMININK, xi.item.SHEET_OF_PARCHMENT }) then
                player:startEvent(7, xi.item.SHEET_OF_PARCHMENT, xi.item.BOTTLE_OF_ILLUMININK) -- Ark Pentasphere Trade
            elseif
                dmRepeat == QUEST_ACCEPTED and
                npcUtil.tradeHasExactly(trade, xi.item.CHUNK_OF_LIGHT_ORE) and
                not player:hasKeyItem(xi.ki.MOONLIGHT_ORE)
            then
                player:startEvent(8) -- Moonlight Ore trade
            end
        end
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 7 then
        if npcUtil.giveItem(player, xi.item.ARK_PENTASPHERE) then
            player:confirmTrade()
        end
    elseif csid == 8 then
        player:tradeComplete()
        player:addKeyItem(xi.ki.MOONLIGHT_ORE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MOONLIGHT_ORE)
    end
end

return entity
