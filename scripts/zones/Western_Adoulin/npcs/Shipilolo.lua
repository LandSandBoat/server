-----------------------------------
-- Area: Western Adoulin
--  NPC: Shipilolo
--  Involved with Quests: 'A Certain Substitute Patrolman'
--                        'Fertile Ground'
--                        'The Old Man and the Harpoon'
--                        'Wayward Waypoints'
-- !pos 84 0 -60 256
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local fertileGround    = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.FERTILE_GROUND)

    if player:getCurrentMission(xi.mission.log_id.SOA) >= xi.mission.id.soa.LIFE_ON_THE_FRONTIER then
        if
            player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.THE_OLD_MAN_AND_THE_HARPOON) == xi.questStatus.QUEST_ACCEPTED and
            player:hasKeyItem(xi.ki.BROKEN_HARPOON)
        then
            -- Progresses Quest: 'The Old Man and the Harpoon'
            player:startEvent(2543)
        elseif
            fertileGround == xi.questStatus.QUEST_ACCEPTED and
            not player:hasKeyItem(xi.ki.BOTTLE_OF_FERTILIZER_X)
        then
            -- Progresses Quest: 'Fertile Ground'
            player:startEvent(2850)
        elseif
            player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.WAYWARD_WAYPOINTS) == xi.questStatus.QUEST_ACCEPTED and
            player:getCharVar('WW_Need_Shipilolo') > 0 and
            not player:hasKeyItem(xi.ki.WAYPOINT_RECALIBRATION_KIT)
        then
            -- Progresses Quest: 'Wayward Waypoints'
            player:startEvent(79)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 2543 then
        -- Progresses Quest: 'The Old Man and the Harpoon'
        player:delKeyItem(xi.ki.BROKEN_HARPOON)
        npcUtil.giveKeyItem(player, xi.ki.EXTRAVAGANT_HARPOON)
    elseif csid == 2850 then
        -- Progresses Quest: 'Fertile Ground' TODO: Should this also give the player a message?
        player:addKeyItem(xi.ki.BOTTLE_OF_FERTILIZER_X)
    elseif csid == 79 then
        player:addKeyItem(xi.ki.WAYPOINT_RECALIBRATION_KIT)
        player:setCharVar('WW_Need_Shipilolo', 0)
    end
end

return entity
