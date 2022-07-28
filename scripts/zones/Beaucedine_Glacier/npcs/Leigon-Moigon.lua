-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Leigon-Moigon
-- !pos 106.567 -21.249 140.770 111
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local foiledAGolem = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CURSES_FOILED_A_GOLEM)

    -- QUEST: CURSES, FOILED A-GOLEM!?
    if foiledAGolem == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.SHANTOTTOS_NEW_SPELL) then
            player:startEvent(107)
        elseif player:getCharVar("foiledagolemdeliverycomplete") == 1 then
            player:startEvent(112)
        else
            player:startEvent(103)
        end

    -- DEFAULT DIALOG
    else
        player:startEvent(103)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
