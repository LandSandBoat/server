-----------------------------------
-- Area: Western Adoulin
--  NPC: Nikkhail
--  Involved With Quest: 'A Thirst for the Ages'
-- !pos -101 3 9 256
-----------------------------------
local ID = zones[xi.zone.WESTERN_ADOULIN]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local atfta = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.A_THIRST_FOR_THE_AGES)
    local atftaNeedKI = player:getCharVar('ATFTA_Status') < 2 and not player:hasKeyItem(xi.ki.COPY_OF_THE_ALLIANCE_AGREEMENT)
    local soaMission = player:getCurrentMission(xi.mission.log_id.SOA)

    if soaMission >= xi.mission.id.soa.LIFE_ON_THE_FRONTIER then
        if atfta == QUEST_ACCEPTED and atftaNeedKI then
            -- Progresses Quest: 'A Thirst for the Ages'
            player:startEvent(5053)
        end
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 5053 then
        -- Progresses Quest: 'A Thirst for the Ages'
        player:addKeyItem(xi.ki.COPY_OF_THE_ALLIANCE_AGREEMENT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.COPY_OF_THE_ALLIANCE_AGREEMENT)
    end
end

return entity
