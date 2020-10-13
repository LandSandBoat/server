-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Raminel
-- Involved in Quests: Riding on the Clouds
-- !pos -56 2 -21 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/pathfind")
require("scripts/globals/quests")
-----------------------------------

local path =
{
    -138.436340, -2.000000, 16.227097,
    -137.395432, -2.000000, 15.831898,
    -136.317108, -2.000000, 15.728185,
    -134.824036, -2.000000, 15.816396,
    -108.897049, -2.000000, 16.508110,
    -107.823288, -2.000000, 16.354126,
    -106.804962, -2.000000, 15.973084,
    -105.844963, -2.000000, 15.462379,
    -104.922585, -2.000000, 14.885456,
    -104.020050, -2.000000, 14.277813,
    -103.138374, -2.000000, 13.640303,
    -101.501289, -2.000000, 12.422975,
    -77.636841, 2.000000, -5.771687,
    -59.468536, 2.000000, -19.632719,
    -58.541172, 2.000000, -20.197826,
    -57.519985, 2.000000, -20.570829,
    -56.474659, 2.000000, -20.872238,
    -55.417450, 2.000000, -21.129019,
    -54.351425, 2.000000, -21.365578,
    -53.286743, 2.000000, -21.589529,
    -23.770412, 2.000000, -27.508755,
    -13.354427, 1.700000, -29.593290,
    -14.421194, 1.700000, -29.379389, -- auction house
    -43.848141, 2.000000, -23.492155,
    -56.516224, 2.000000, -20.955723,
    -57.555450, 2.000000, -20.638817,
    -58.514832, 2.000000, -20.127840,
    -59.426712, 2.000000, -19.534536,
    -60.322998, 2.000000, -18.917839,
    -61.203823, 2.000000, -18.279247,
    -62.510002, 2.000000, -17.300892,
    -86.411278, 2.000000, 0.921999,
    -105.625214, -2.000000, 15.580724,
    -106.582047, -2.000000, 16.089426,
    -107.647263, -2.000000, 16.304668,
    -108.732132, -2.000000, 16.383970,
    -109.819397, -2.000000, 16.423687,
    -110.907364, -2.000000, 16.429226,
    -111.995232, -2.000000, 16.411282,
    -140.205811, -2.000000, 15.668728,  -- package Lusiane
    -139.296539, -2.000000, 16.786556
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)

    -- test fromStart
    local start = tpz.path.fromStart(path, 2)
    local startFirst = tpz.path.get(path, 3)

    if (start[1] ~= startFirst[1] or start[2] ~= startFirst[2] or start[3] ~= startFirst[3]) then
        printf("[Error] start path is not right %f %f %f actually = %f %f %f", startFirst[1], startFirst[2], startFirst[3], start[1], start[2], start[3])
    end

    -- test fromEnd
    -- local endPt = tpz.path.fromEnd(path, 2)
    -- local endFirst = tpz.path.get(path, 37)

    -- if (endPt[1] ~= endFirst[1] or endPt[2] ~= endFirst[2] or endPt[3] ~= endFirst[3]) then
    --     printf("[Error] endPt path is not right %f %f %f actually = %f %f %f", endFirst[1], endFirst[2], endFirst[3], endPt[1], endPt[2], endPt[3])
    -- end
end

function onPath(npc)
    if (npc:atPoint(tpz.path.get(path, 23))) then
        npc:lookAt(GetNPCByID(ID.npc.ARPETION):getPos())
        npc:wait()
    elseif (npc:atPoint(tpz.path.get(path, -1))) then
        -- give package to Lusiane, wait 4 seconds, then continue
        local lus = GetNPCByID(ID.npc.LUSIANE)
        lus:showText(npc, ID.text.RAMINEL_DELIVERY)
        npc:showText(lus, ID.text.LUSIANE_THANK)
        npc:wait()
    elseif (npc:atPoint(tpz.path.last(path))) then
        -- when I walk away stop looking at me
        GetNPCByID(ID.npc.LUSIANE):clearTargID()
    end

    -- go back and forth the set path
    tpz.path.patrol(npc, path)
end

function onTrade(player, npc, trade)
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_1") == 1) then
        if (trade:hasItemQty(1127, 1) and trade:getItemCount() == 1) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_1", 0)
            player:tradeComplete()
            player:addKeyItem(tpz.ki.SCOWLING_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SCOWLING_STONE)
        end
    end
end

function onTrigger(player, npc)
    player:startEvent(614)
    npc:wait()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
    npc:wait(0)
end
