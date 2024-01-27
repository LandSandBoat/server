-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Mulaujeant
-- Involved in Quests: Missionary Man
-- !pos -175 0 181 231
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local finishtime = player:getCharVar('MissionaryMan_date')
    local missionaryManVar = player:getCharVar('MissionaryManVar')

    if missionaryManVar == 2 then
        player:startEvent(698, 0, 1146) -- Start statue creation
    elseif missionaryManVar == 3 and finishtime > os.time() then
        player:startEvent(699) -- During statue creation
    elseif missionaryManVar == 3 and finishtime <= os.time() then
        player:startEvent(700) -- End of statue creation
    elseif missionaryManVar == 4 then
        player:startEvent(701) -- During quest (after creation)
    else
        player:startEvent(697) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 698 then
        player:setCharVar('MissionaryManVar', 3)
        player:setCharVar('MissionaryMan_date', os.time() + 60)
        player:delKeyItem(xi.ki.RAUTEINOTS_PARCEL)
        player:needToZone(true)

    elseif csid == 700 then
        player:setCharVar('MissionaryManVar', 4)
        player:setCharVar('MissionaryMan_date', 0)
        player:addKeyItem(xi.ki.SUBLIME_STATUE_OF_THE_GODDESS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SUBLIME_STATUE_OF_THE_GODDESS)
    end
end

return entity
