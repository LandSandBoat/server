-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Potete
-- Type: NPC
-- !pos 104.907 -21.249 141.391 111
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local FoiledAGolem = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CURSES_FOILED_A_GOLEM)
    local copMission = player:getCurrentMission(COP)
    local copStatus = player:getCharVar("PromathiaStatus")

    -- QUEST: CURSES, FOILED A-GOLEM!?
    if FoiledAGolem == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.SHANTOTTOS_NEW_SPELL) then
            player:startEvent(106)
        elseif player:getCharVar("foiledagolemdeliverycomplete") == 1 then
            player:startEvent(111)
        else
            player:startEvent(102)
        end

    -- CoP 5-2: DESIRES OF EMPTINESS
    elseif copStatus > 8 and copMission == xi.mission.id.cop.DESIRES_OF_EMPTINESS then
        player:startEvent(213)

    -- CoP ?-?: MISSING DIALOG (NEEDS RESEARCH!)
    -- player:startEvent(217)
    -- Tells location of Prishe (https://youtu.be/gVWzFDHf5v8)
    -- I think its linked to Ulima's Quest on Three Paths (Where Messengers Gather)

    -- DEFAULT DIALOG
    else
        player:startEvent(102)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
