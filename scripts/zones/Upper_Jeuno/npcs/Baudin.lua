-----------------------------------
-- Area: Upper Jeuno
--  NPC: Baudin
-- Starts and Finishes Quest: Crest of Davoi, Save My Sister
-- Involved in Quests: Save the Clock Tower
-- !pos -75 0 80 244
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if trade:hasItemQty(555, 1) and trade:getItemCount() == 1 then
        local a = player:getCharVar("saveTheClockTowerNPCz2") -- NPC Zone2
        if
            a == 0 or
            (
                a ~= 32 and
                a ~= 96 and
                a ~= 160 and
                a ~= 288 and
                a ~= 544 and
                a ~= 224 and
                a ~= 800 and
                a ~= 352 and
                a ~= 672 and
                a ~= 416 and
                a ~= 608 and
                a ~= 480 and
                a ~= 736 and
                a ~= 864 and
                a ~= 928 and
                a ~= 992
            )
        then
            player:startEvent(177, 10 - player:getCharVar("saveTheClockTowerVar")) -- "Save the Clock Tower" Quest
        end
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 177 then
        player:incrementCharVar("saveTheClockTowerVar", 1)
        player:incrementCharVar("saveTheClockTowerNPCz2", 32)
    end
end

return entity
