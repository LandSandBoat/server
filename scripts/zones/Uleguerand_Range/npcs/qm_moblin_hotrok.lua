-----------------------------------
-- Area: Uleguerand_Range
--  NPC: ??? (Trade Moblin Hotrok for Map of Uleguerand Range)
-- !pos -299 -62 -18
-- Involved in Quests: Over The Hills And Far Away
-----------------------------------
local ID = require("scripts/zones/Uleguerand_Range/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    local overTheHillsAndFarAway = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.OVER_THE_HILLS_AND_FAR_AWAY)
    local louverancesPath = player:getCharVar("COP_Louverance_s_Path")

    -- Taking a logical guess what criteria displays what message.
    if overTheHillsAndFarAway == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 1729) then -- 1729 = Moblin Hotrok
        if louverancesPath >= 10 then
            if player:hasTitle(xi.title.COMPANION_OF_LOUVERANCE) or player:hasTitle(xi.title.TRUE_COMPANION_OF_LOUVERANCE) then
                player:startEvent(10, 0, 1729, xi.ki.MAP_OF_THE_ULEGUERAND_RANGE, 0, 0, 1, 0)
                --                                                                       ^ 1 = Remembers you and girl from Tavnazia and asks to TRADE dagger for map
            else
                player:startEvent(10, 0, 1729, xi.ki.MAP_OF_THE_ULEGUERAND_RANGE, 1, 0, 1, 0)
                --                                                                 ^ 1   ^ 1 = Remembers you and girl from Tavnazia and asks for the dagger
            end
        else
            if player:hasTitle(xi.title.COMPANION_OF_LOUVERANCE) or player:hasTitle(xi.title.TRUE_COMPANION_OF_LOUVERANCE) then
                player:startEvent(10, 0, 1729, xi.ki.MAP_OF_THE_ULEGUERAND_RANGE, 0, 1, 0, 0)
                --                                                                    ^ 1 = Doesn't recognize you and asks to TRADE dagger for map
                -- or
                --                                                                          ^ 1 = Doesn't recognize you and asks to TRADE dagger for map
            else
                player:startEvent(10, 0, 1729, xi.ki.MAP_OF_THE_ULEGUERAND_RANGE, 1, 0, 0, 0)
                --                                                                 ^ 1 = Doesn't recognize you and asks for the dagger
            end
        end
    end

end

entity.onTrigger = function(player, npc)

    local overTheHillsAndFarAway = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.OVER_THE_HILLS_AND_FAR_AWAY)

    if overTheHillsAndFarAway == QUEST_COMPLETED then
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    elseif overTheHillsAndFarAway == QUEST_ACCEPTED then
        player:messageSpecial(ID.text.SOMETHING_GLITTERING)
        player:messageSpecial(ID.text.WHAT_LIES_BENEATH, 0, 1729)
    else
        player:messageSpecial(ID.text.SOMETHING_GLITTERING_BUT)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if csid == 10 and npcUtil.completeQuest(player, SANDORIA, xi.quest.id.sandoria.OVER_THE_HILLS_AND_FAR_AWAY, {gil = 2000, xp = 2000, ki = xi.ki.MAP_OF_THE_ULEGUERAND_RANGE}) then
        player:confirmTrade()
    end

end

return entity
