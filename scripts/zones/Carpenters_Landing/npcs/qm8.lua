-----------------------------------
-- Area: Carpenters' Landing
--  NPC: ??? (qm2)
--  Involved in Missions: Calm Before the Storm (CoP 7-4)
-- !pos 120.615 -5.457 -390.133 2
-----------------------------------
local ID = require("scripts/zones/Carpenters_Landing/IDs")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local cop = player:getCurrentMission(COP)
    local k1 = player:getCharVar("Cryptonberry_Assassins-1_KILL")
    local k2 = player:getCharVar("Cryptonberry_Assassins-2_KILL")
    local k3 = player:getCharVar("Cryptonberry_Assassins-3_KILL")
    local executorKill = player:getCharVar("Cryptonberry_Executor_KILL")
    local executor = GetMobByID(ID.mob.CRYPTONBERRY_EXECUTOR)

    if cop == tpz.mission.id.cop.CALM_BEFORE_THE_STORM and (k1 * k2 * k3 * executorKill) == 1 then
        player:startEvent(37)
    elseif
        cop == tpz.mission.id.cop.CALM_BEFORE_THE_STORM and
        executorKill < 2 and
        not executor:isSpawned() and
        not GetMobByID(ID.mob.CRYPTONBERRY_EXECUTOR + 1):isSpawned() and
        not GetMobByID(ID.mob.CRYPTONBERRY_EXECUTOR + 2):isSpawned() and
        not GetMobByID(ID.mob.CRYPTONBERRY_EXECUTOR + 3):isSpawned()
    then
        player:messageSpecial(ID.text.CRYPTONBERRY_EXECUTOR_POP)
        executor:spawn()
        executor:updateClaim(player)
        executor:setCE(player, 0) -- CE is used to spawn Assassins
    else
        player:messageSpecial(ID.text.CRYPTONBERRY_FALLEN_TREE)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 37 then
        player:setCharVar("Cryptonberry_Executor_KILL", 2)
        player:setCharVar("Cryptonberry_Assassins-1_KILL", 0)
        player:setCharVar("Cryptonberry_Assassins-2_KILL", 0)
        player:setCharVar("Cryptonberry_Assassins-3_KILL", 0)
    end
end
