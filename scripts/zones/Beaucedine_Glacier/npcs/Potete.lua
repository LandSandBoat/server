-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Potete
-- Type: NPC
-- !pos 104.907 -21.249 141.391 111
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
            player:startEvent(106)
        elseif player:getCharVar("foiledagolemdeliverycomplete") == 1 then
            player:startEvent(111)
        else
            player:startEvent(102)
        end
    else
        player:startEvent(102)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
