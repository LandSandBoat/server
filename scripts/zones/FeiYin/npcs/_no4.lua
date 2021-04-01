-----------------------------------
-- Area: Fei'Yin
--  NPC: Cermet Door (triggers Rukususu dialog)
-- Type: Quest NPC
-- !pos -183 0 190 204
--     Involved in Quests: Curses, Foiled A-Golem!?, SMN AF2: Class Reunion, SMN AF3: Carbuncle Debacle
--    Involved in Missions: Windurst 5-1/7-2/8-2
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
local ID = require("scripts/zones/FeiYin/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    -- Windurst 8-2
    if (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and player:getCharVar("MissionStatus") == 1) then
        player:startEvent(22)

    -- Curses, Foiled A_Golem!?
    elseif (player:hasKeyItem(xi.ki.SHANTOTTOS_NEW_SPELL)) then
        player:startEvent(14) -- deliver spell
    elseif (player:hasKeyItem(xi.ki.SHANTOTTOS_EXSPELL)) then
        player:startEvent(13) -- spell erased, try again!

    -- standard dialog
    else
        player:startEvent(15)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    -- Curses, Foiled A_Golem!?
    if (csid == 14) then
        player:setCharVar("foiledagolemdeliverycomplete", 1)
        player:delKeyItem(xi.ki.SHANTOTTOS_NEW_SPELL) -- remove key item
    elseif (csid == 22) then
        player:addKeyItem(xi.ki.RHINOSTERY_RING)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.RHINOSTERY_RING)
        if (player:hasKeyItem(xi.ki.AURASTERY_RING) and player:hasKeyItem(xi.ki.OPTISTERY_RING)) then
            player:setCharVar("MissionStatus", 2)
        end
    end
end

return entity
