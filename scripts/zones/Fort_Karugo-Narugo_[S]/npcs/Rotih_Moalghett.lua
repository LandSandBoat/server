-----------------------------------
-- Area: Fort Karugo Narugo [S]
--  NPC: Rotih_Moalghett
-- Type: Quest
-- !pos -64 -75 4 96
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STRIKES) == xi.questStatus.QUEST_ACCEPTED then
        if player:getCharVar('TigressStrikesProg') == 1 then
            player:startEvent(101)
        else
            player:startEvent(104)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 104 then
        player:setCharVar('TigressStrikesProg', 1)
    end
end

return entity
