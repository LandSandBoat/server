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
    -- Curses, Foiled A_Golem!?
    if player:hasKeyItem(xi.ki.SHANTOTTOS_NEW_SPELL) then
        player:startEvent(14) -- deliver spell
    elseif player:hasKeyItem(xi.ki.SHANTOTTOS_EX_SPELL) then
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
    if csid == 14 then
        player:setCharVar("foiledagolemdeliverycomplete", 1)
        player:delKeyItem(xi.ki.SHANTOTTOS_NEW_SPELL) -- remove key item
    end
end

return entity
