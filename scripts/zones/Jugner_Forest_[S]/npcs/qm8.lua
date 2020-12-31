-----------------------------------
-- Area: Jugner Forest (S)
--  NPC: ???
-- Type: Quest NPC
-- !pos -6 0 -295 82
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest_[S]/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local wotg = player:getQuestStatus(tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.WRATH_OF_THE_GRIFFON)
    local wotgStat = player:getCharVar("WrathOfTheGriffon")

    if wotg == QUEST_ACCEPTED and wotgStat == 0 then
        player:startEvent(204)
    elseif player:getCharVar("CobraClawKilled") == 1 then
        player:startEvent(206)
    elseif player:getCharVar("WrathOfTheGriffon") == 1 and not GetMobByID(ID.mob.COBRACLAW_BUCHZVOTCH):isSpawned() then
        player:startEvent(205)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 204 then
        player:setCharVar("WrathOfTheGriffon", 1)
    elseif csid == 205 then
        SpawnMob(ID.mob.COBRACLAW_BUCHZVOTCH):updateClaim(player)
    elseif csid == 206 then
        player:setCharVar("CobraClawKilled", 0)
        player:setCharVar("WrathOfTheGriffon", 2)
    end
end
