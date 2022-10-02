-----------------------------------
-- Area: Fei'Yin
--  NPC: Rukususu
-- Involved in Quests: Curses, Foiled A-Golem!?, SMN AF2: Class Reunion, SMN AF3: Carbuncle Debacle
-- Involved in Missions: Windurst 5-1/7-2/8-2
-- !pos -194.133 -0.986 191.077 204
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/missions")
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
