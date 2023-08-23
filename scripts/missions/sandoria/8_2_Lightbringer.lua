-----------------------------------
-- Lightbringer
-- San d'Oria M8-2
-----------------------------------
-- !addmission 0 21
-- Ambrotien             : !pos 93.419 -0.001 -57.347 230
-- Grilau                : !pos -241.987 6.999 57.887 231
-- Endracion             : !pos -110 1 -34 230
-- (_6h4) Great Hall     : !pos 0 -1 13 233
-- Rahal                 : !pos -28 0.1 -6 233
-- Door: Prince Royal's  : !pos -38 -3 73 233
-- Door: Prince Regent's : !pos -37 -3 31 233
-- Halver                : !pos 2 0.1 0.1 233
-- qm11                  : !pos -13 -17 -151 159
-- qm12                  : !pos -32 -17 -153 159
-- qm13                  : !pos -68 -17 -153 159
-- Granite Door          : !pos -50 -17 -154 159
-----------------------------------
local chateauID   = zones[xi.zone.CHATEAU_DORAGUILLE]
local uggalepihID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.LIGHTBRINGER)

mission.reward =
{
    rank = 9,
    gil = 80000,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 21 then
        mission:begin(player)
    end
end

-- There is a cutscene that must be viewed after completing M8-1 (Coming of Age).  This is
-- handled with the mission variable 'Mission[0][20]Progress', and is handled in that mission
-- script. If this is non-zero, gate guard interaction will be blocked.
mission.sections =
{
    -- Player has no active missions
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            onEventFinish =
            {
                [1009] = handleAcceptMission,
                [2009] = handleAcceptMission,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            onEventFinish =
            {
                [1009] = handleAcceptMission,
            },
        },
    },

    -- Player has accepted the mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['_6h4'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(100)
                    elseif missionStatus == 6 then
                        return mission:progressEvent(104)
                    end
                end,
            },

            ['Aramaviont'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 6 then
                        return mission:progressEvent(15)
                    end
                end,
            },

            ['Curilla'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 2 then
                        return mission:progressEvent(57)
                    elseif missionStatus == 6 then
                        return mission:progressEvent(103)
                    end
                end,
            },

            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 6 then
                        return mission:messageText(chateauID.text.LIGHTBRINGER_EXTRA):replaceDefault()
                    end
                end,
            },

            ['Milchupain'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 6 then
                        return mission:progressEvent(36)
                    end
                end,
            },

            ['Rahal'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 1 then
                        return mission:progressEvent(106)
                    elseif missionStatus == 2 then
                        return mission:progressEvent(107)
                    elseif missionStatus == 6 then
                        return mission:progressEvent(105)
                    end
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [104] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.CRYSTAL_DOWSER)
                    end
                end,

                [106] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                    npcUtil.giveKeyItem(player, xi.ki.CRYSTAL_DOWSER)
                end,
            }
        },

        [xi.zone.TEMPLE_OF_UGGALEPIH] =
        {
            ['_4fv'] =
            {
                onTrigger = function(player, npc)
                    local nioA = GetMobByID(uggalepihID.mob.NIO_A)
                    local nioHum = GetMobByID(uggalepihID.mob.NIO_HUM)

                    if
                        player:getMissionStatus(mission.areaId) == 5 and
                        player:hasKeyItem(xi.ki.PIECE_OF_A_BROKEN_KEY1) and
                        player:hasKeyItem(xi.ki.PIECE_OF_A_BROKEN_KEY2) and
                        player:hasKeyItem(xi.ki.PIECE_OF_A_BROKEN_KEY3) and
                        (not nioA:isSpawned() or nioA:isDead()) and
                        (not nioHum:isSpawned() or nioHum:isDead())
                    then
                        if mission:getVar(player, 'Prog') > 0 then
                            return mission:progressEvent(65)
                        else
                            SpawnMob(uggalepihID.mob.NIO_A)
                            SpawnMob(uggalepihID.mob.NIO_HUM)
                            return mission:messageSpecial(uggalepihID.text.BEGINS_TO_QUIVER, xi.ki.CRYSTAL_DOWSER)
                        end
                    end
                end,
            },

            -- Only one of these NMs are required to progress, but the mob must despawn while in combat with
            -- the other target.
            ['Nio-A'] =
            {
                onMobDeath = function(mob, player, optParams)
                    local mobNioHum = GetMobByID(uggalepihID.mob.NIO_HUM)

                    if
                        player:getMissionStatus(mission.areaId) == 5 and
                        (mobNioHum:isDead() or not mobNioHum:isSpawned())
                    then
                        mission:setVar(player, 'Prog', 1)
                    end
                end,
            },

            ['Nio-Hum'] =
            {
                onMobDeath = function(mob, player, optParams)
                    local mobNioA = GetMobByID(uggalepihID.mob.NIO_A)

                    if
                        player:getMissionStatus(mission.areaId) == 5 and
                        (mobNioA:isDead() or not mobNioA:isSpawned())
                    then
                        mission:setVar(player, 'Prog', 1)
                    end
                end,
            },

            ['qm11'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.PIECE_OF_A_BROKEN_KEY1) and
                        player:getMissionStatus(mission.areaId) >= 2
                    then
                        player:setMissionStatus(mission.areaId, player:getMissionStatus(mission.areaId) + 1)
                        return mission:keyItem(xi.ki.PIECE_OF_A_BROKEN_KEY1)
                    end
                end,
            },

            ['qm12'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.PIECE_OF_A_BROKEN_KEY2) and
                        player:getMissionStatus(mission.areaId) >= 2
                    then
                        player:setMissionStatus(mission.areaId, player:getMissionStatus(mission.areaId) + 1)
                        return mission:keyItem(xi.ki.PIECE_OF_A_BROKEN_KEY2)
                    end
                end,
            },

            ['qm13'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.PIECE_OF_A_BROKEN_KEY3) and
                        player:getMissionStatus(mission.areaId) >= 2
                    then
                        player:setMissionStatus(mission.areaId, player:getMissionStatus(mission.areaId) + 1)
                        return mission:keyItem(xi.ki.PIECE_OF_A_BROKEN_KEY3)
                    end
                end,
            },

            onEventFinish =
            {
                [65] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 6)
                end,
            },
        },
    },

    -- Optional dialogue after completing the Mission.  Prince cutscenes are once events, and the
    -- 'Option' mission variable needs to be reset on accepting the next mission.  We could have started
    -- with bits set, but should a player skip these, it'd persist forever.
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId) and
                player:getRank(mission.areaId) == 9 and
                player:getRankPoints() == 0
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['_6h0'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Option', 0) then
                        return mission:progressEvent(63)
                    end
                end
            },

            ['_6h1'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Option', 1) then
                        return mission:progressEvent(74)
                    end
                end
            },

            ['Aramaviont'] = mission:messageText(chateauID.text.LIGHTBRINGER_EXTRA + 1),
            ['Milchupain'] = mission:messageText(chateauID.text.LIGHTBRINGER_EXTRA + 3),
            ['Rahal']      = mission:event(42):replaceDefault(),

            onEventFinish =
            {
                [63] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Option', 0)
                end,

                [74] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Option', 1)
                end,
            },
        },
    },
}

return mission
