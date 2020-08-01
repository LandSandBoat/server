-----------------------------------
-- Area: Batallia Downs (S)
--  NPC: Thorben
-- Type: Quest NPC
-- !pos  175.346, 8.038, -419.244 84
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local lostInTranslocation = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.LOST_IN_TRANSLOCATION)
    local leftMapPiece = player:hasKeyItem(tpz.ki.LEFT_MAP_PIECE)
    local middleMapPiece = player:hasKeyItem(tpz.ki.MIDDLE_MAP_PIECE)
    local rightMapPiece = player:hasKeyItem(tpz.ki.RIGHT_MAP_PIECE)
    local anyMapPiece = leftMapPiece or middleMapPiece or rightMapPiece

    if lostInTranslocation == QUEST_COMPLETED then
        player:startEvent(108)
    elseif lostInTranslocation == QUEST_ACCEPTED and leftMapPiece and middleMapPiece and rightMapPiece then
        player:startEvent(107)
    elseif player:getCharVar("lostInTranslocationCS") == 1 then
        player:startEvent(106)
    elseif lostInTranslocation == QUEST_ACCEPTED and anyMapPiece then
        player:startEvent(105)
    elseif lostInTranslocation == QUEST_ACCEPTED and not anyMapPiece then
        player:startEvent(104)
    else
        player:startEvent(103)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 107 then
        if player:hasKeyItem(tpz.ki.MAP_OF_GRAUBERG) then
            npcUtil.completeQuest(player, CRYSTAL_WAR, tpz.quest.id.crystalWar.LOST_IN_TRANSLOCATION, {
                gil = 2000,
                xp = 2000,
                var = "lostInTranslocationCS"
            })
        else
            npcUtil.completeQuest(player, CRYSTAL_WAR, tpz.quest.id.crystalWar.LOST_IN_TRANSLOCATION, {
                keyItem = tpz.ki.MAP_OF_GRAUBERG,
                var = "lostInTranslocationCS"
            })
        end
        player:delKeyItem(tpz.ki.LEFT_MAP_PIECE)
        player:delKeyItem(tpz.ki.MIDDLE_MAP_PIECE)
        player:delKeyItem(tpz.ki.RIGHT_MAP_PIECE)
    elseif csid == 105 then
        player:setCharVar("lostInTranslocationCS", 1)
    elseif csid == 103 then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.LOST_IN_TRANSLOCATION)
    end
end
