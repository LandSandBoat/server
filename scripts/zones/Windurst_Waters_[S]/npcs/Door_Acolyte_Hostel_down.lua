-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Door Acolyte Hostel
-- !pos  124.000, -3.000, 222.215 94
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STIRS) == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.SMALL_STARFRUIT)
    then
        player:startEvent(129)
    elseif
        player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STRIKES) == xi.questStatus.QUEST_COMPLETED and
        player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.KNOT_QUITE_THERE) == xi.questStatus.QUEST_AVAILABLE
    then
        if
            player:getCurrentMission(xi.mission.log_id.WOTG) == xi.mission.id.wotg.CAIT_SITH or
            player:hasCompletedMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.CAIT_SITH)
        then
            player:startEvent(151)
        end
    elseif player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.KNOT_QUITE_THERE) == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(152)
    else
        player:messageSpecial(ID.text.DOOR_ACOLYTE_HOSTEL_LOCKED)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 129 then
        player:addItem(xi.item.HI_ELIXIR)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 4144)
        player:delKeyItem(xi.ki.SMALL_STARFRUIT)
        player:completeQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STIRS)
    elseif csid == 151 then
        player:addQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.KNOT_QUITE_THERE)
    end
end

return entity
