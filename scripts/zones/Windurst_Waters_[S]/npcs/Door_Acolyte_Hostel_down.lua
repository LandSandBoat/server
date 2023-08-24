-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Door Acolyte Hostel
-- Type: Quest NPC
-- !pos  124.000, -3.000, 222.215 94
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
require("scripts/globals/missions")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STIRS) == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.SMALL_STARFRUIT)
    then
        player:startEvent(129)
    elseif
        player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STRIKES) == QUEST_COMPLETED and
        player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.KNOT_QUITE_THERE) == QUEST_AVAILABLE
    then
        if
            player:getCurrentMission(xi.mission.log_id.WOTG) == xi.mission.id.wotg.CAIT_SITH or
            player:hasCompletedMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.CAIT_SITH)
        then
            player:startEvent(151)
        end
    elseif player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.KNOT_QUITE_THERE) == QUEST_ACCEPTED then
        player:startEvent(152)
    else
        player:messageSpecial(ID.text.DOOR_ACOLYTE_HOSTEL_LOCKED)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 129 then
        player:addItem(4144) -- hi-elixir
        player:messageSpecial(ID.text.ITEM_OBTAINED, 4144)
        player:delKeyItem(xi.ki.SMALL_STARFRUIT)
        player:completeQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STIRS)
    elseif csid == 151 then
        player:addQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.KNOT_QUITE_THERE)
    end
end

return entity
