-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Rohn Ehlbalna
-- !pos -43.473 -4.5 46.496 94
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.REDEEMING_ROCKS) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('RedeemingRocksProg') == 1
    then
        player:startEvent(114) -- 2nd CS quest "Redeeming Rocks"
    else
        player:startEvent(440)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 114 then -- Finish "Redeeming Rocks" second CS
        player:setCharVar('RedeemingRocksProg', 2)
    end
end

return entity
