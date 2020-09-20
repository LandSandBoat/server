-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Door Acolyte Hostel
-- Type: Quest NPC
-- !pos  124.000, -3.000, 222.215 94
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if
        player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_TIGRESS_STIRS) == QUEST_ACCEPTED and
        player:hasKeyItem(tpz.ki.SMALL_STARFRUIT)
    then
        player:startEvent(129)
    elseif
        player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_TIGRESS_STRIKES) == QUEST_COMPLETED and
        player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.KNOT_QUITE_THERE) == QUEST_AVAILABLE
    then
        if player:getCurrentMission(WOTG) == tpz.mission.id.wotg.CAIT_SITH or player:hasCompletedMission(WOTG, tpz.mission.id.wotg.CAIT_SITH) then
            player:startEvent(151)
        end
    elseif player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.KNOT_QUITE_THERE) == QUEST_ACCEPTED then
        player:startEvent(152)
    else
        player:messageSpecial(ID.text.DOOR_ACOLYTE_HOSTEL_LOCKED)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 129 then
        player:addItem(4144) -- hi-elixir
        player:messageSpecial(ID.text.ITEM_OBTAINED, 4144)
        player:delKeyItem(tpz.ki.SMALL_STARFRUIT)
        player:addKeyItem(tpz.ki.BRASS_RIBBON_OF_SERVICE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BRASS_RIBBON_OF_SERVICE)
        player:completeQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_TIGRESS_STIRS)
    elseif csid == 151 then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.KNOT_QUITE_THERE)
    end
end
