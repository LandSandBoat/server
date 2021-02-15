-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Leigon-Moigon
-- !pos 106.567 -21.249 140.770 111
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local FoiledAGolem = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.CURSES_FOILED_A_GOLEM)

    if FoiledAGolem == QUEST_ACCEPTED then
        if player:hasKeyItem(tpz.ki.SHANTOTTOS_NEW_SPELL) then
            player:startEvent(107)
        elseif player:getCharVar("foiledagolemdeliverycomplete") == 1 then
            player:startEvent(112)
        else
            player:startEvent(103)
        end
    else
        player:startEvent(103)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
