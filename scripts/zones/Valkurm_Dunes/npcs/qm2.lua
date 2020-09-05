-----------------------------------
-- Area: Valkurm Dunes
-- NPC:  qm2 (???)
-- Involved In Quest: Messenger from Beyond
-- !pos -716 -10 66 103
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
require("scripts/globals/quests")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (not GetMobByID(ID.mob.MARCHELUTE):isSpawned() and player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.MESSENGER_FROM_BEYOND) == QUEST_ACCEPTED and not player:hasItem(1096)) then
        SpawnMob(ID.mob.MARCHELUTE):updateClaim(player)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
