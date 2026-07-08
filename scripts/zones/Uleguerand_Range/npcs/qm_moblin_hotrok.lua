-----------------------------------
-- Area: Uleguerand_Range
--  NPC: ??? (Trade Moblin Hotrok for Map of Uleguerand Range)
-- !pos -299 -62 -18
-- Involved in Quests: Over The Hills And Far Away
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- TODO: This logic needs to be verified, and conditions slimmed down.  Companion of Louverance is granted on completion of that path,
-- while True Companion is granted during the Ulmia path.

entity.onTrade = function(player, npc, trade)
    local overTheHillsAndFarAway = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.OVER_THE_HILLS_AND_FAR_AWAY)

    -- Taking a logical guess what criteria displays what message.
    if
        overTheHillsAndFarAway == xi.questStatus.QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, xi.item.MOBLIN_HOTROK)
    then
        -- 1729 = Moblin Hotrok
        if player:getMissionStatus(xi.mission.log_id.COP, xi.mission.status.COP.LOUVERANCE) == 14 then
            if
                player:hasTitle(xi.title.COMPANION_OF_LOUVERANCE) or
                player:hasTitle(xi.title.TRUE_COMPANION_OF_LOUVERANCE)
            then
                player:startEvent(10, 0, 1729, xi.ki.MAP_OF_THE_ULEGUERAND_RANGE, 0, 0, 1, 0)
                --                                                                      ^ 1 = Remembers you and girl from Tavnazia and asks to TRADE dagger for map
            else
                player:startEvent(10, 0, 1729, xi.ki.MAP_OF_THE_ULEGUERAND_RANGE, 1, 0, 1, 0)
                --                                                                ^ 1   ^ 1 = Remembers you and girl from Tavnazia and asks for the dagger
            end
        else
            if
                player:hasTitle(xi.title.COMPANION_OF_LOUVERANCE) or
                player:hasTitle(xi.title.TRUE_COMPANION_OF_LOUVERANCE)
            then
                player:startEvent(10, 0, 1729, xi.ki.MAP_OF_THE_ULEGUERAND_RANGE, 0, 1, 0, 0)
                --                                                                   ^ 1 = Doesn't recognize you and asks to TRADE dagger for map
                -- or
                --                                                                          ^ 1 = Doesn't recognize you and asks to TRADE dagger for map
            else
                player:startEvent(10, 0, 1729, xi.ki.MAP_OF_THE_ULEGUERAND_RANGE, 1, 0, 0, 0)
                --                                                                ^ 1 = Doesn't recognize you and asks for the dagger
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local overTheHillsAndFarAway = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.OVER_THE_HILLS_AND_FAR_AWAY)

    if overTheHillsAndFarAway == xi.questStatus.QUEST_COMPLETED then
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    elseif overTheHillsAndFarAway == xi.questStatus.QUEST_ACCEPTED then
        player:messageSpecial(ID.text.SOMETHING_GLITTERING)
        player:messageSpecial(ID.text.WHAT_LIES_BENEATH, 0, xi.item.MOBLIN_HOTROK)
    else
        player:messageSpecial(ID.text.SOMETHING_GLITTERING_BUT)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 10 and
        npcUtil.completeQuest(player, xi.questLog.SANDORIA, xi.quest.id.sandoria.OVER_THE_HILLS_AND_FAR_AWAY, {
            keyItem = xi.ki.MAP_OF_THE_ULEGUERAND_RANGE,
            gil = 2000,
            exp = 2000
        })
    then
        player:confirmTrade()
    end
end

return entity
