-----------------------------------
-- Desires of Emptiness
-- Promathia 5-2
-----------------------------------
-- !addmission 6 518
-- Stone Door    : !pos -380 46.074 330.5 9
-- _0mc (Flux 1) : !pos 180 -2.5 -60 22
-- _0md (Flux 2) : !pos 420 -2.5 140 22
-- _0m0 (Flux 3) : !pos -340 -2.5 140 22
-- Cid           : !pos -12 -12 1 237
-----------------------------------
local promyvionVahzlID = zones[xi.zone.PROMYVION_VAHZL]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.DESIRES_OF_EMPTINESS)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.THREE_PATHS },
}

local vahzlPositions =
{
    [1] = {  -14.744, 0.036, -119.736,   1, 22 },
    [2] = {  183.546,     0,  -59.906,   0, 22 },
    [3] = {  415.757,     0,  139.977, 128, 22 },
    [4] = { -336.001,     0,  139.815,   0, 22 },
}

local function setPromyvionVahzlPos(player, csid, option, npc)
    if option >= 1 and option <= 4 then
        player:setPos(unpack(vahzlPositions[option]))
    end
end

-- 'Option' variable bitfield
-- NM kill data persists on logout on retail.  This may not be the case if the player
-- leaves the zone, but that logic is not implemented at this time.

--   .----------------------- Ponderer CS Viewed
--   |   .------------------- Solicitor CS Viewed
--   |   |   .--------------- Propagator CS Viewed
--   |   |   |   .----------- Ponderer Defeated
--   |   |   |   |   .------- Solicitor Defeated
--   |   |   |   |   |   .--- Propagator Defeated
--   |   |   |   |   |   |
-- +---+---+---+---+---+---+
-- | 5 | 4 | 3 | 2 | 1 | 0 | (Bit Position)
-- +---+---+---+---+---+---+

local memoryFluxInfo =
{
    ['_0mc'] = { 0, promyvionVahzlID.mob.PROPAGATOR, 51 },
    ['_0md'] = { 1, promyvionVahzlID.mob.SOLICITOR,  52 },
    ['_0m0'] = { 2, promyvionVahzlID.mob.PONDERER,   53 },
}

local memoryFluxOnTrigger = function(player, npc)
    local fluxInfo = memoryFluxInfo[npc:getName()]

    if
        not mission:isVarBitsSet(player, 'Option', fluxInfo[1]) and
        not GetMobByID(fluxInfo[2]):isSpawned()
    then
        SpawnMob(fluxInfo[2]):updateClaim(player)
        return mission:messageSpecial(promyvionVahzlID.text.ON_NM_SPAWN)
    elseif not mission:isVarBitsSet(player, 'Option', fluxInfo[1] + 3) then
        return mission:progressEvent(fluxInfo[3])
    end
end

local memoryFluxOnEventFinish = function(player, csid, option, npc)
    local fluxInfo = memoryFluxInfo[npc:getName()]

    mission:setVarBit(player, 'Option', fluxInfo[1] + 3)

    if mission:isVarBitsSet(player, 'Option', 3, 4, 5) then
        mission:setVar(player, 'Status', 1)
    end
end

-- TODO: Find a way to do this algorithmically.  This aligns with the upper three
-- bits of the Option variable for having viewed CS, and impacts what areas you are
-- allowed to teleport to from the Promyvion-Vahzl entrance.
local psoXjaEventIdByOffset =
{
    [0] = 50,
    [1] = 106,
    [2] = 107,
    [3] = 109,
    [4] = 108,
    [5] = 110,
    [6] = 111,
    [7] = 112,
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.PROMYVION_VAHZL] =
        {
            ['_0mc'] =
            {
                onTrigger = memoryFluxOnTrigger,
            },

            ['_0md'] =
            {
                onTrigger = memoryFluxOnTrigger,
            },

            ['_0m0'] =
            {
                onTrigger = memoryFluxOnTrigger,
            },

            ['Propagator'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if not mission:isVarBitsSet(player, 'Option', 0) then
                        mission:setVarBit(player, 'Option', 0)
                    end
                end,
            },

            ['Solicitor'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if not mission:isVarBitsSet(player, 'Option', 1) then
                        mission:setVarBit(player, 'Option', 1)
                    end
                end,
            },

            ['Ponderer'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if not mission:isVarBitsSet(player, 'Option', 2) then
                        mission:setVarBit(player, 'Option', 2)
                    end
                end,
            },

            onEventFinish =
            {
                [51] = memoryFluxOnEventFinish,
                [52] = memoryFluxOnEventFinish,
                [53] = memoryFluxOnEventFinish,
            },
        },

        [xi.zone.PSOXJA] =
        {
            ['_i99'] =
            {
                onTrigger = function(player, npc)
                    local eventOffset = bit.rshift(mission:getVar(player, 'Option'), 3)

                    return mission:progressEvent(psoXjaEventIdByOffset[eventOffset])
                end,
            },

            onEventFinish =
            {
                [50]  = setPromyvionVahzlPos,
                [106] = setPromyvionVahzlPos,
                [107] = setPromyvionVahzlPos,
                [108] = setPromyvionVahzlPos,
                [109] = setPromyvionVahzlPos,
                [110] = setPromyvionVahzlPos,
                [111] = setPromyvionVahzlPos,
                [112] = setPromyvionVahzlPos,
            },
        },

        [xi.zone.SPIRE_OF_VAHZL] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 1 then
                        if bit.rshift(mission:getVar(player, 'Option'), 3) == 7 then
                            return 20
                        else
                            return 21
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [20] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                end,

                [21] = function(player, csid, option, npc)
                    player:setPos(-140.011, 0, -53.990, 192, 22)
                end,

                [32001] = function(player, csid, option, npc)
                    if
                        player:getLocalVar('battlefieldWin') == 864 and
                        mission:getVar(player, 'Status') == 2
                    then
                        mission:setVar(player, 'Status', 3)
                    end
                end,
            },
        },

        [xi.zone.BEAUCEDINE_GLACIER] =
        {
            ['Leigon-Moigon'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 4 then
                        return mission:event(212):importantEvent()
                    end
                end,
            },

            ['Potete'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 4 then
                        return mission:event(213):importantEvent()
                    end
                end,
            },

            ['Torino-Samarino'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 4 then
                        return mission:event(211):importantEvent()
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 3 then
                        return 206
                    end
                end,
            },

            onEventUpdate =
            {
                [206] = function(player, csid, option, npc)
                    player:updateEvent(0, xi.ki.MYSTERIOUS_AMULET)
                end,
            },

            onEventFinish =
            {
                [206] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 4)
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 4 then
                        return mission:progressEvent(850)
                    end
                end,
            },

            onEventFinish =
            {
                [850] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.PSOXJA] =
        {
            ['_i99'] = mission:event(112),

            onEventFinish =
            {
                [112] = setPromyvionVahzlPos,
            },
        },
    },
}

return mission
