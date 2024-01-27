-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Dhea Prandoleh
-- !pos 1 -1 15 94
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS_S]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCampaignAllegiance() > 0 and
        player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STIRS) == QUEST_AVAILABLE
    then
        player:startEvent(128)
    elseif player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STIRS) == QUEST_ACCEPTED then
        player:startEvent(160)
    elseif
        player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STIRS) == QUEST_COMPLETED and
        player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STRIKES) == QUEST_AVAILABLE
    then
        player:startEvent(133)
    elseif player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STRIKES) == QUEST_ACCEPTED then
        if player:getCharVar('TigressStrikesProg') < 3 then
            player:startEvent(135)
        elseif player:getCharVar('TigressStrikesProg') == 3 then
            player:startEvent(134)
        end
    else
        player:startEvent(136)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 128 then
        player:addQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STIRS)
    elseif csid == 133 then
        player:addQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STRIKES)
    elseif csid == 134 then
        player:addItem(xi.item.STAR_GLOBE)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.STAR_GLOBE)
        player:completeQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STRIKES)
        player:needToZone(true)
        player:addTitle(xi.title.AJIDO_MARUJIDOS_MINDER)
    end
end

return entity
