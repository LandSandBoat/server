-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Oaken Box
-- Involved In Quest: Peace for the Spirit
-- !pos -164 0.1 225 200
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.PEACE_FOR_THE_SPIRIT) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 1094)) then -- Nail Puller
        player:startEvent(14)
    end
end

function onTrigger(player, npc)
    if (player:getCharVar("peaceForTheSpiritCS") == 4 and not player:hasItem(1094) and not GetMobByID(ID.mob.GUARDIAN_STATUE):isSpawned()) then -- Nail Puller
        player:messageSpecial(ID.text.SENSE_OF_FOREBODING)
        SpawnMob(ID.mob.GUARDIAN_STATUE):updateClaim(player)
    else
        player:messageSpecial(ID.text.YOU_FIND_NOTHING)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 14) then
        player:confirmTrade()
        player:setCharVar("peaceForTheSpiritCS", 5)
    end
end
