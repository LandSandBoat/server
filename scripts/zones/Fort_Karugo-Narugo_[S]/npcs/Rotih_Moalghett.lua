-----------------------------------
-- Area: Fort Karugo Narugo [S]
--  NPC: Rotih_Moalghett
-- Type: Quest
-- !pos -64 -75 4 96
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STRIKES) == QUEST_ACCEPTED then
        if player:getCharVar('TigressStrikesProg') == 1 then
            player:startEvent(101)
        else
            player:startEvent(104)
        end
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 104 then
        player:setCharVar('TigressStrikesProg', 1)
    end
end

return entity
