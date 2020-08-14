-----------------------------------
-- Area: Fei'Yin
--  NPC: Rukususu (talk to Cermet Door _no5 to trigger)
-- Type: Quest NPC
-- !pos -194.133 -0.986 191.077 204
--     Involved in quests: Curses, Foiled A-Golem!?, SMN AF2: Class Reunion, SMN AF3: Carbuncle Debacle
--    Involved in Missions: Windurst 5-1/7-2/8-2
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Curses, Foiled A_Golem!?
    if (player:hasKeyItem(tpz.ki.SHANTOTTOS_NEW_SPELL)) then
        player:startEvent(14) -- deliver spell
    elseif (player:hasKeyItem(tpz.ki.SHANTOTTOS_EXSPELL)) then
        player:startEvent(13) -- spell erased, try again!

    -- standard dialog
    else
        player:startEvent(15)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    -- Curses, Foiled A_Golem!?
    if (csid == 14) then
        player:setCharVar("foiledagolemdeliverycomplete", 1)
        player:delKeyItem(tpz.ki.SHANTOTTOS_NEW_SPELL) -- remove key item
    end
end
