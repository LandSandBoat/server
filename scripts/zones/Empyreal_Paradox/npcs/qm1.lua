-----------------------------------
-- Area: Empyreal_Paradox
--  NPC: ??? (qm1)
-----------------------------------
local ID = zones[xi.zone.EMPYREAL_PARADOX]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- TODO: Use xi.items enum and table items.
    if
        player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) and
        not player:hasItem(xi.item.STATIC_EARRING) and
        not player:hasItem(xi.item.MAGNETIC_EARRING) and
        not player:hasItem(xi.item.HOLLOW_EARRING) and
        not player:hasItem(xi.item.ETHEREAL_EARRING)
    then
        player:startEvent(5)
    else
        player:messageSpecial(ID.text.QM_TEXT)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 5 and option == 1 then
        player:delMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LAST_VERSE)
        player:delMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_LAST_VERSE)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)
        player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.AWAKENING)
        player:setMissionStatus(xi.mission.log_id.ZILART, 3)
        player:setCharVar('PromathiaStatus', 7)
        player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED)
        player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH)
    end
end

return entity
