-----------------------------------
-- Area: Monastic Cavern
--  NPC: Altar
-- Involved in Quests: The Circle of Time
-- !pos 108 -2 -144 150
-----------------------------------
local ID = zones[xi.zone.MONASTIC_CAVERN]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local circleOfTime = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_CIRCLE_OF_TIME)

    if
        circleOfTime == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.STAR_RING1) and
        player:hasKeyItem(xi.ki.MOON_RING)
    then
        if
            player:getCharVar('circleTime') == 7 and
            npcUtil.popFromQM(player, npc, ID.mob.BUGABOO, { hide = 0 })
        then
            -- no further action needed
        elseif player:getCharVar('circleTime') == 8 then
            player:startEvent(3)
        else
            player:messageSpecial(ID.text.ALTAR)
        end
    else
        player:messageSpecial(ID.text.ALTAR)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 3 then
        player:setCharVar('circleTime', 9)
        player:delKeyItem(xi.ki.MOON_RING)
        player:delKeyItem(xi.ki.STAR_RING1)
    end
end

return entity
