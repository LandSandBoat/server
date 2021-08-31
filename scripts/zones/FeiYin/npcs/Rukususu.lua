-----------------------------------
-- Area: Fei'Yin
--  NPC: Rukususu
-- Involved in Quests: Curses, Foiled A-Golem!?, SMN AF2: Class Reunion, SMN AF3: Carbuncle Debacle
-- Involved in Missions: Windurst 5-1/7-2/8-2
-- !pos -194.133 -0.986 191.077 204
-----------------------------------
require("scripts/globals/quests")
require("scripts/settings/main")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- The Jester Who'd Be King (Windurst 8-2)
    if
        player:getCurrentMission(WINDURST) == xi.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and
        player:getMissionStatus(player:getNation()) == 1 and not
        player:hasKeyItem(xi.ki.RHINOSTERY_RING)
    then
        player:startEvent(22, 0, xi.ki.RHINOSTERY_RING)

    -- Curses, Foiled A_Golem!?
    elseif player:hasKeyItem(xi.ki.SHANTOTTOS_NEW_SPELL) then
        player:startEvent(14) -- deliver spell
    elseif player:hasKeyItem(xi.ki.SHANTOTTOS_EXSPELL) then
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

    -- The Jester Who'd Be King (Windurst 8-2)
    elseif csid == 22 and npcUtil.giveKeyItem(player, xi.ki.RHINOSTERY_RING) then
        if player:hasKeyItem(xi.ki.AURASTERY_RING) and player:hasKeyItem(xi.ki.OPTISTERY_RING) then
            player:setMissionStatus(player:getNation(), 2)
        end
    end
end

return entity
