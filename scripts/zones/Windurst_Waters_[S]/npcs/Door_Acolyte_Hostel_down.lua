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
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 129 then
        player:addItem(xi.item.HI_ELIXIR)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 4144)
        player:delKeyItem(xi.ki.SMALL_STARFRUIT)
        player:completeQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STIRS)
    end
end

return entity
