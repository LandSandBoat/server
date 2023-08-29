-----------------------------------
-- Area: The Garden of RuHmet
--  NPC: Ebon_Panel
-- !pos 100.000 -5.180 -337.661 35 | Mithra Tower
-- !pos 740.000 -5.180 -342.352 35 | Elvaan Tower
-- !pos 257.650 -5.180 -699.999 35 | Tarutaru Tower
-- !pos 577.648 -5.180 -700.000 35 | Galka Tower
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local playerRace = player:getRace()
    local xPos = npc:getXPos()

    if
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.WHEN_ANGELS_FALL and
        player:getCharVar('PromathiaStatus') == 1
    then
        player:startEvent(202)
    elseif
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.WHEN_ANGELS_FALL and
        player:getCharVar('PromathiaStatus') == 2
    then
        if xPos > 99 and xPos < 101 then -- Mithra Tower
            if playerRace == xi.race.MITHRA then
                player:startEvent(124)
            else
                player:messageSpecial(ID.text.NO_NEED_INVESTIGATE)
            end
        elseif xPos > 739 and xPos < 741 then -- Elvaan Tower
            if playerRace == xi.race.ELVAAN_M or playerRace == xi.race.ELVAAN_F then
                player:startEvent(121)
            else
                player:messageSpecial(ID.text.NO_NEED_INVESTIGATE)
            end
        elseif xPos > 256 and xPos < 258 then -- Tarutaru Tower
            if playerRace == xi.race.TARU_M or playerRace == xi.race.TARU_F then
                player:startEvent(123)
            else
                player:messageSpecial(ID.text.NO_NEED_INVESTIGATE)
            end
        elseif xPos > 576 and xPos < 578 then -- Galka Tower
            if playerRace == xi.race.GALKA then
                player:startEvent(122)
            else
                player:messageSpecial(ID.text.NO_NEED_INVESTIGATE)
            end
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
    elseif csid == 124 and option ~= 0 then -- Mithra
        player:addTitle(xi.title.WARRIOR_OF_THE_CRYSTAL)
        player:setCharVar('PromathiaStatus', 3)
        player:addKeyItem(xi.ki.LIGHT_OF_DEM)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIGHT_OF_DEM)
    elseif csid == 121 and option ~= 0 then -- Elvaan
        player:addTitle(xi.title.WARRIOR_OF_THE_CRYSTAL)
        player:setCharVar('PromathiaStatus', 3)
        player:addKeyItem(xi.ki.LIGHT_OF_MEA)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIGHT_OF_MEA)
    elseif csid == 123 and option ~= 0 then -- Tarutaru
        player:addTitle(xi.title.WARRIOR_OF_THE_CRYSTAL)
        player:setCharVar('PromathiaStatus', 3)
        player:addKeyItem(xi.ki.LIGHT_OF_HOLLA)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIGHT_OF_HOLLA)
    elseif csid == 122 and option ~= 0 then -- Galka
        player:addTitle(xi.title.WARRIOR_OF_THE_CRYSTAL)
        player:setCharVar('PromathiaStatus', 3)
        player:addKeyItem(xi.ki.LIGHT_OF_ALTAIEU)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIGHT_OF_ALTAIEU)
    end
end

return entity
