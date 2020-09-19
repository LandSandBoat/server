-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Rohn Ehlbalna
-- Type: Standard NPC
-- !pos -43.473 -4.5 46.496 94
-----------------------------------
function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.REDEEMING_ROCKS) == QUEST_ACCEPTED and
        player:getCharVar("RedeemingRocksProg") == 1 then
        player:startEvent(114) -- 2nd CS quest "Redeeming Rocks"
    else
        player:startEvent(440)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 114 then -- Finish "Redeeming Rocks" second CS
        player:setCharVar("RedeemingRocksProg", 2)
    end
end
