-----------------------------------
-- Area: The Garden of RuHmet
--  NPC: _iz2 (Ebon_Panel)
-- !pos 422.351 -5.180 -100.000 35 | Hume Tower
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local playerRace = player:getRace()

    if
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.WHEN_ANGELS_FALL and
        player:getCharVar('PromathiaStatus') == 1
    then
        player:startEvent(202)
    elseif
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.WHEN_ANGELS_FALL and
        player:getCharVar('PromathiaStatus') == 2
    then
        if playerRace == xi.race.HUME_M or playerRace == xi.race.HUME_F then
            player:startEvent(120)
        else
            player:messageSpecial(ID.text.NO_NEED_INVESTIGATE)
        end
    else
        player:messageSpecial(ID.text.NO_NEED_INVESTIGATE)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 202 then
        player:setCharVar('PromathiaStatus', 2)
    elseif csid == 120 and option ~= 0 then -- Hume
        player:addTitle(xi.title.WARRIOR_OF_THE_CRYSTAL)
        player:setCharVar('PromathiaStatus', 3)
        player:addKeyItem(xi.ki.LIGHT_OF_VAHZL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIGHT_OF_VAHZL)
    end
end

return entity
