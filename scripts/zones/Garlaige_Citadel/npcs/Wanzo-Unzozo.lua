-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Wanzo-Unzozo
-- Type: Quest NPC (Escort for Hire - Windurst)
-- !pos -381 -12 398
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/pathfind")
require("scripts/globals/quests")
-----------------------------------
ID = require('scripts/zones/Garlaige_Citadel/IDs')
-----------------------------------
local entity = {}

local route =
{
    -381.0000, -12.0000, 398.0000,
    -380.8830, -12.0000, 391.8802,
    -378.7068, -6.12510, 368.4137,
    -379.2549, -6.00000, 346.8558,
    -357.3971, -6.00000, 338.0250,
    -341.3876, -3.25000, 339.8453,
    -340.9149, 0.000000, 297.0475,
    -336.8979, 0.000000, 288.6178,
    -342.1649, 0.000000, 270.2281,
    -354.1182, 0.000000, 268.7367,
    -354.2867, 0.000000, 249.9196,
    -340.2825, 0.000000, 249.7256,
    -337.6853, 0.000000, 221.3183,
    -314.6676, 0.000000, 218.6108,
    -300.1329, 0.000000, 226.1669,
    -275.1773, 0.000000, 217.3463,
    -271.0707, 0.000000, 219.7949, -- Middle of holes
    -237.1567, 0.000000, 218.0966,
    -180.1768, 0.000000, 221.7442,
    -178.3567, 0.000000, 259.3759,
    -143.2720, 0.000000, 262.7013,
    -138.2194, 0.000000, 230.2753,
    -125.7615, 0.000000, 229.9893,
    -126.1223, 0.000000, 217.9252,
    -133.0517, 0.000000, 204.5436, -- Dead End
    -126.1223, 0.000000, 217.9252,
    -125.7615, 0.000000, 229.9893,
    -138.2194, 0.000000, 230.2753,
    -138.9951, 0.000000, 254.4034,
    -106.9740, 0.000000, 262.5682,
    -100.8588, 0.000000, 256.1013,
    -97.54940, 0.000000, 222.0876,
    -65.87720, 0.000000, 217.7562,
    -57.52250, 0.000000, 192.7869,
    -60.73950, 5.927000, 153.6628, -- Basement
    -54.09130, 7.176200, 143.8619,
    -42.03350, 6.000000, 144.9311,
    -30.21860, 7.443100, 137.7087,
    -17.81050, 6.567400, 147.5737,
    -16.16890, 8.139700, 138.4585,
    -20.54190, 6.000000, 118.7473,
    -19.41390, 2.750000, 101.3711,
    -101.4705, 0.000000, 100.9095,
    -167.2571, 0.000000, 98.46240,
    -177.5856, 0.000000, 94.07690,
    -210.6050, 0.000000, 102.8821,
    -220.0769, 0.000000, 110.8499,
    -216.9912, 0.000000, 128.0300,
    -219.6814, 0.000000, 139.8317, -- Destination
}

-- Reset Wazon to spawn point and reset AI
local resetWazon = function(npc)
    npc:setStatus(xi.status.DISAPPEAR)
    npc:setPos(-381.1,-12,398, 1)
    npc:resetAI()
end

entity.onSpawn = function(npc)
    npc:initNpcAi()
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("Quest[2][88]Prog") >= 1 then
        -- Begin, Wazon!
        if npc:getLocalVar("begin") == 0 then
            local party = player:getParty()
            npc:setLocalVar("begin", 1)

            for _, v in ipairs(party) do
                if v:getZone() == player:getZone() then
                    v:setCharVar("Quest[2][88]Prog", 2)
                end
            end
            npc:messageText(npc, ID.text.TIME_LIMIT)
            npc:setLocalVar("timer", os.time() + 1800)
            npc:setLocalVar("run", 1)

        -- Stop, Wazon!
        elseif npc:getLocalVar("run") == 1 then
            npc:setLocalVar("run", 0)
            npc:messageText(npc, ID.text.WHATS_WRONG)

        -- Run, Wazon!
        elseif npc:getLocalVar("run") == 0 then
            npc:setLocalVar("run", 1)
            npc:messageText(npc, ID.text.LETS_GO)

        -- We won, Wazon!
        elseif npc:getLocalVar("win") == 1 then
            npc:messageText(npc, ID.text.I_THANK_YOU)
            if not player:hasKeyItem(xi.ki.COMPLETION_CERTIFICATE) then
                -- Setting var to 3 disallows player from interacting with this quest any further
                player:setCharVar("Quest[2][88]Prog", 3)
                npcUtil.giveKeyItem(player, xi.ki.COMPLETION_CERTIFICATE)
            end
        end
    end
end

entity.onPath = function(npc)
    -- Finish line achieved
    if npc:atPoint(xi.path.last(route)) and npc:getLocalVar("win") == 0 then
        npc:setLocalVar("run", 3)
        npc:setLocalVar("win", 1)
        npc:timer(30000, function(npcArg)
            npc:messageText(npc, ID.text.BYE_BYE)
            resetWazon(npc)
        end)

    -- Run case
    elseif npc:getLocalVar("run") == 1 then
        xi.path.patrol(npc, route)

    -- Time up case
    elseif npc:getLocalVar("timer") < os.time() then
        npc:setStatus(xi.status.DISAPPEAR)
        resetWazon(npc)
    end
end

entity.onDeath = function(npc)
    npc:messageText(npc, ID.text.LOST_SIGHT)
    resetWazon(npc)
end

return entity
