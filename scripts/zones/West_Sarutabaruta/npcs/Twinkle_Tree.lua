-----------------------------------
-- Area: West Sarutabaruta
--  NPC: Twinkle Tree
-- Involved in Quest: To Catch a Falling Star
--  Note: EventID for Twinkle Tree is unknown. Quest funtions but the full event is not played.
-- !pos 156.003 -40.753 333.742 115
-----------------------------------
local ID = zones[xi.zone.WEST_SARUTABARUTA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TO_CATCH_A_FALLING_STAR) == xi.questStatus.QUEST_ACCEPTED and
        VanadielHour() <= 3
    then
        if
            npcUtil.tradeHas(trade, xi.item.HANDFUL_OF_PUGIL_SCALES) and
            player:getCharVar('QuestCatchAFallingStar_prog') == 0
        then
            player:messageSpecial(ID.text.FROST_DEPOSIT_TWINKLES)
            player:messageSpecial(ID.text.MELT_BARE_HANDS)
            if npcUtil.giveItem(player, xi.item.STARFALL_TEAR) then
                player:confirmTrade()
                player:setCharVar('QuestCatchAFallingStar_prog', 1)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    if
        VanadielHour() <= 3 and
        player:getCharVar('QuestCatchAFallingStar_prog') == 0
    then
        player:messageSpecial(ID.text.FROST_DEPOSIT_TWINKLES)
        player:messageSpecial(ID.text.MELT_BARE_HANDS)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
