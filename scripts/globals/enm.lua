------------------------------------------
-- Shared functionality for ENM timer NPCs
--  Ophelia (Southern San dOria)
--  Gregory (Bastok Mines)
--  Istvan (Windurst Woods)
--  Moritz (Upper Jeuno)
------------------------------------------
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/zone")
-----------------------------------
xi = xi or {}
xi.enm = xi.enm or {}

local cutscenes =
{
    ["Moritz"]  = { introduction = 10028, recurring = 10029, default = 10027 },
    ["Ophelia"] = { introduction = 752,   recurring = 753,   default = 751 },
    ["Gregory"] = { introduction = 257,   recurring = 258,   default = 256 },
    ["Istvan"]  = { introduction = 693,   recurring = 694,   default = 692 },
}

local enmOptionToEnablementCriteria =
{
    [1]   = { missionReq = xi.mission.id.cop.THE_RITES_OF_LIFE,    cooldownPlayerVar = "[ENM]abandonmentTimer" }, --Spire Of Holla
    [2]   = { missionReq = xi.mission.id.cop.THE_RITES_OF_LIFE,    cooldownPlayerVar = "[ENM]antipathyTimer" },   --Spire Of Dem
    [3]   = { missionReq = xi.mission.id.cop.THE_RITES_OF_LIFE,    cooldownPlayerVar = "[ENM]animusTimer" },      --Spire Of Mea
    [4]   = { missionReq = xi.mission.id.cop.SLANDEROUS_UTTERINGS, cooldownPlayerVar = "[ENM]acrimonyTimer" },    --Spire Of Vahzl
    [5]   = { missionReq = xi.mission.id.cop.AN_ETERNAL_MELODY,    cooldownPlayerVar = "[ENM]MonarchBeard" },     --Monarch Linn
    [6]   = { missionReq = xi.ki.PSOXJA_PASS,                      cooldownPlayerVar = "[ENM]AstralCovenant" },   --The Shrouded Maw
    [7]   = { missionReq = nil,                                    cooldownPlayerVar = "[ENM]OperatingLever" },   --Mine Shaft 2716 Lever
    [8]   = { missionReq = nil,                                    cooldownPlayerVar = "[ENM]ZephyrFan" },        --Bearclaw Pinnacle
    [9]   = { missionReq = nil,                                    cooldownPlayerVar = "[ENM]MiasmaFilter" },     --Boneyard Gully
    [100] = { missionReq = nil,                                    cooldownPlayerVar = "[ENM]GateDial" },         --Mine Shaft 2716 Dial
}

local function hasPlayerTriggeredEnmCoolDown(player)
    for _, v in pairs(enmOptionToEnablementCriteria) do
        if player:getCharVar(v.cooldownPlayerVar) then
            return true
        end
    end

    return false
end

local function getBitmaskForAvailableENMs(player)
    -- The cutscene allows filtering of which ENMs are shown to the player
    -- 2^option aligns the bitmask to the ENM
    local bitmask = 0
    local copMissionProgress = player:getCurrentMission(xi.mission.log_id.COP)

    for i = 1, 5 do
        if copMissionProgress <= enmOptionToEnablementCriteria[i].missionReq then
            bitmask = bitmask + bit.lshift(1, i)
        end
    end

    -- Special case for AstralCovenant, which is holding a ki vs a mission
    if not player:hasKeyItem(xi.ki.PSOXJA_PASS) then
        bitmask = bitmask + bit.lshift(1, 6)
    end

    -- Note: Bearclaw Pinnacle, Boneyard Gully, and Mine Shaft 2716 are never filtered
    return bitmask
end

xi.enm.timerNpcOnTrigger = function(player, npc)
    local hasPlayerAckdIntro = player:getCharVar(string.format("[ENM]" ..npc:getName().. "IntroCS")) == 1
    -- reusing hasPlayerAckdIntro to prevent querying multiple player vars (enm timers) each interaction
    if hasPlayerAckdIntro or hasPlayerTriggeredEnmCoolDown(player) then
        if not hasPlayerAckdIntro then
            player:startEvent(cutscenes[npc:getName()].introduction, getBitmaskForAvailableENMs(player))
        else
            player:startEvent(cutscenes[npc:getName()].recurring, getBitmaskForAvailableENMs(player))
        end
    else
        player:startEvent(cutscenes[npc:getName()].default)
    end
end

xi.enm.timerNpcOnEventUpdate = function(player, csid, option)
    -- update required for a decline
    if option == 0 then
        player:updateEvent(1)
        return
    end

    local enmAvailableVanaTime = player:getCharVar(enmOptionToEnablementCriteria[option].cooldownPlayerVar)
    if enmAvailableVanaTime > VanadielTime() then
        player:updateEvent(0, enmAvailableVanaTime)
    else
        player:updateEvent(0)
    end
end

xi.enm.timerNpcOnEventFinish = function(player, csid, option)
    local npc = player:getEventTarget()
    -- Handle intro CS
    if
        csid == cutscenes[npc:getName()].introduction and option >= 0 and
        option <= 100
    then
        player:setCharVar(string.format("[ENM]" ..npc:getName().. "IntroCS"), 1)
    end
end
