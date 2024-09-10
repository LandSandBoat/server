-----------------------------------
-- A Challenge! You Could Be a Winner
-- A Moogle Kupo d'Etat M13
-- !addmission 10 12
-----------------------------------
-- Puzzle 1 - Beaucedine
-- Shadowy Pillar   : !pos 374 -12 -15 161
-- Lonely Evergreen : !pos -162 -80 178 111
-- Goblin Grenadier : !pos -26 -59 -76 111
-----------------------------------
-- Puzzle 2 - Xarcabard
-- Option_One   : !pos 126 -24 -118 112
-- Option_One   : !pos 66 -24 -191 112
-- Option_Three : !pos 1 -23 -103 112
-----------------------------------
-- Puzzle 3 - Castle Zvahl Baileys
-- Shadowy Pillar : !pos 374 -12 -15 161
-- Flame Of Fate  : !pos -155 -24 17 161
-----------------------------------
-- Puzzle 4 - Castle Zvahl Keep
-- Ominous Pillar  : !pos -7 -1.5 -23.6 162
-- Craggy Pillar 1 : !pos -208 -52.5 -87.5 162
-- Craggy Pillar 2 : !pos -448 -68 -11.5 162
-- Craggy Pillar 3 : !pos -368 -52.5 -127.5 162
-- Craggy Pillar 4 : !pos -236 -52 103 162
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.A_CHALLENGE_YOU_COULD_BE_A_WINNER)

mission.reward =
{
    nextMission = { xi.mission.log_id.AMK, xi.mission.id.amk.SMASH_A_MALEVOLENT_MENACE },
}

mission.sections =
{
    -- Part 1: Castle Zvahl Baileys
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId and
                not player:hasKeyItem(xi.ki.GAUNTLET_CHALLENGE_KUPON)
        end,

        [xi.zone.CASTLE_ZVAHL_BAILEYS] =
        {
            ['Shadowy_Pillar'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(100, 3)
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    if mission:getVar(player, 'progress') == 0 then
                        mission:setVar(player, 'progress', 1)
                    end
                end,
            },
        },
    },

    -- Part 2-a: Beaucedine Glacier
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId and
                (mission:getVar(player, 'progress') == 1 or
                currentMission > mission.missionId) and
                not player:hasKeyItem(xi.ki.POCKET_MOGBOMB) and
                not player:hasKeyItem(xi.ki.TRIVIA_CHALLENGE_KUPON) and
                player:needToZone() == false
        end,

        [xi.zone.BEAUCEDINE_GLACIER] =
        {
            ['Lonely_Evergreen'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(504)
                end,
            },

            onEventFinish =
            {
                [504] = function(player, csid, option, npc)
                    if mission:getVar(player, 'progress') == 0 then
                        mission:setVar(player, 'progress', 1)
                    end

                    if option == 1 then
                        player:needToZone(true)
                    end
                end,
            },
        },
    },

    -- Part 2-b: Beaucedine Glacier - Puzzle 1
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId and
                mission:getVar(player, 'progress') == 1 and
                not player:hasKeyItem(xi.ki.POCKET_MOGBOMB) and
                not player:hasKeyItem(xi.ki.TRIVIA_CHALLENGE_KUPON) and
                player:needToZone() == true
        end,

        [xi.zone.BEAUCEDINE_GLACIER] =
        {
            ['Lonely_Evergreen'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(503)
                end,
            },

            ['Goblin_Grenadier'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.MAP_OF_THE_NORTHLANDS_AREA) then
                        return mission:event(509)
                    end

                    local answer = mission:getLocalVar(player, '[p1]pipSet') - 1

                    if answer < 0 then
                        return mission:progressEvent(508, xi.ki.MAP_OF_THE_NORTHLANDS_AREA)
                    else
                        local today = VanadielDayOfTheWeek()
                        local tomorrow = (today + 1) % 8
                        local hintsUsed = mission:getLocalVar(player, '[p1]hintsUsed')

                        player:messageSpecial(zones[player:getZoneID()].text.GRENADIER_DAY_HINT, today, tomorrow)

                        return mission:progressEvent(
                            507,
                            hintsUsed + 2,
                            answer,
                            xi.ki.MAP_OF_THE_NORTHLANDS_AREA,
                            xi.ki.POCKET_MOGBOMB,
                            xi.ki.MAP_OF_THE_NORTHLANDS_AREA
                        )
                    end
                end,
            },

            ['Northwestern_Pip'] =
            {
                onTrigger = function(player, npc)
                    return xi.amk.helpers.puzzleOneOnTrigger(player, npc, mission, 1)
                end,
            },

            ['Western_Pip'] =
            {
                onTrigger = function(player, npc)
                    return xi.amk.helpers.puzzleOneOnTrigger(player, npc, mission, 2)
                end,
            },

            ['Southwestern_Pip'] =
            {
                onTrigger = function(player, npc)
                    return xi.amk.helpers.puzzleOneOnTrigger(player, npc, mission, 3)
                end,
            },

            ['Northeastern_Pip'] =
            {
                onTrigger = function(player, npc)
                    return xi.amk.helpers.puzzleOneOnTrigger(player, npc, mission, 4)
                end,
            },

            ['Eastern_Pip'] =
            {
                onTrigger = function(player, npc)
                    return xi.amk.helpers.puzzleOneOnTrigger(player, npc, mission, 5)
                end,
            },

            ['Southeastern_Pip'] =
            {
                onTrigger = function(player, npc)
                    return xi.amk.helpers.puzzleOneOnTrigger(player, npc, mission, 6)
                end,
            },

            onEventUpdate =
            {
                [507] = function(player, csid, option, npc)
                    -- This updateEvent updates the markers on the map to track which pips have already been found,
                    -- and can alter what the map shows when a pip is checked.  If not called here, the args
                    -- for hints used and answer get input as markers and erroneously show incorrect pips
                    -- All zeros = only show what have been found so far
                    player:updateEvent(0, 0, 0, 0, 0, 0)
                end,
            },

            onEventFinish =
            {
                [507] = function(player, csid, option, npc)
                    if
                        option == 1 or -- Used first hint
                        option == 2    -- Used second hint
                    then
                        local hintsUsed = mission:getLocalVar(player, '[p1]hintsUsed')
                        mission:setLocalVar(player, '[p1]hintsUsed', hintsUsed + 1)
                    elseif option == 3 then
                        -- wrong answer, reset puzzle
                        mission:setLocalVar(player, '[p1]pipSet', 0)
                        mission:setLocalVar(player, '[p1]hintsUsed', 0)
                        player:needToZone(false)
                    -- elseif option == 4 then
                        -- Player chooses to exit the chat, or tries to get a third hint,
                        -- which doesn't exist.  Two hints max
                    elseif
                        option == 5 or -- Correct answer, no hints used
                        option == 6 or -- Correct answer, one hint used
                        option == 7    -- Correct answer, two hints used
                    then
                        player:needToZone(false)
                        npcUtil.giveKeyItem(player, xi.ki.POCKET_MOGBOMB)

                        -- Add flee affect, base 5 minutes for no hints used, 3 for 1 hint, no flee for 2 hints
                        local fleeDuration =
                        {
                            [5] = 300,
                            [6] = 180,
                        }

                        if option == 5 or option == 6 then
                            player:addStatusEffect(xi.effect.FLEE, 100, 0, fleeDuration[option])
                        end
                    end
                end,

                [508] = function(player, csid, option, npc)
                    -- Pipset offset by 1 to account for saving 0 as a variable.  When retrieving, subtract 1
                    mission:setLocalVar(player, '[p1]pipSet', math.random(1, 10)) -- range: 0 - 9
                end,
            },
        },
    },

    -- Part 2-c: Beaucedine Glacier
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId and
                mission:getVar(player, 'progress') == 1 and
                player:hasKeyItem(xi.ki.POCKET_MOGBOMB)
        end,

        [xi.zone.BEAUCEDINE_GLACIER] =
        {
            ['Lonely_Evergreen'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(502, xi.ki.POCKET_MOGBOMB, xi.ki.TRIVIA_CHALLENGE_KUPON)
                end,
            },

            ['Goblin_Grenadier'] =
            {
                onTrigger = function(player, npc)
                    -- Reminder to take mogbomb to lonely evergreen moogle
                    player:messageSpecial(zones[player:getZoneID()].text.GRENADIER_TAKE_PRIZE, xi.ki.POCKET_MOGBOMB)
                end,
            },

            onEventFinish =
            {
                [502] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.POCKET_MOGBOMB)
                    npcUtil.giveKeyItem(player, xi.ki.TRIVIA_CHALLENGE_KUPON)
                    mission:setVar(player, 'progress', 2)
                end,
            },
        },
    },

    -- Part 3: Xarcabard - Puzzle 2
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId and
                mission:getVar(player, 'progress') == 2 and
                player:hasKeyItem(xi.ki.TRIVIA_CHALLENGE_KUPON)
        end,

        [xi.zone.BEAUCEDINE_GLACIER] =
        {
            ['Lonely_Evergreen'] =
            {
                onTrigger = function(player, npc)
                    -- Reminder text
                    return mission:progressEvent(501, xi.ki.TRIVIA_CHALLENGE_KUPON)
                end,
            },
        },

        [xi.zone.XARCABARD] =
        {
            ['Option_One'] =
            {
                onTrigger = function(player, npc)
                    return xi.amk.helpers.puzzleTwoOnTrigger(player, npc, mission)
                end,
            },

            ['Option_Two'] =
            {
                onTrigger = function(player, npc)
                    return xi.amk.helpers.puzzleTwoOnTrigger(player, npc, mission)
                end,
            },

            ['Option_Three'] =
            {
                onTrigger = function(player, npc)
                    return xi.amk.helpers.puzzleTwoOnTrigger(player, npc, mission)
                end,
            },

            onEventUpdate =
            {
                [200] = function(player, csid, option, npc)
                    xi.amk.helpers.puzzleTwoOnEventUpdate(player, csid, option, npc, mission)
                end,
            },

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    xi.amk.helpers.puzzleTwoOnEventFinish(player, csid, option, npc, mission)
                end
            },
        },
    },

    -- Part 4: Castle Zvahl Baileys - Puzzle 3
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId and
                mission:getVar(player, 'progress') == 3 and
                player:hasKeyItem(xi.ki.GAUNTLET_CHALLENGE_KUPON)
        end,

        [xi.zone.XARCABARD] =
        {
            ['Option_One'] =
            {
                onTrigger = function(player, npc)
                    return xi.amk.helpers.puzzleTwoOnTrigger(player, npc, mission)
                end,
            },

            ['Option_Two'] =
            {
                onTrigger = function(player, npc)
                    return xi.amk.helpers.puzzleTwoOnTrigger(player, npc, mission)
                end,
            },

            ['Option_Three'] =
            {
                onTrigger = function(player, npc)
                    return xi.amk.helpers.puzzleTwoOnTrigger(player, npc, mission)
                end,
            },
        },

        [xi.zone.CASTLE_ZVAHL_BAILEYS] =
        {
            ['Shadowy_Pillar'] =
            {
                onTrigger = function(player, npc)
                    if not player:needToZone() then
                        return mission:progressEvent(100, 1)
                    else
                        return mission:progressEvent(100, 2)
                    end
                end,
            },

            ['Flame_of_Fate'] =
            {
                onTrigger = function(player, npc)
                    player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)

                    if not player:needToZone() then
                        return mission:progressEvent(101, 4)
                    elseif mission:getLocalVar(player, '[p3]timeLimit') < os.time() then
                        return mission:progressEvent(101, 1)
                    else
                        return mission:progressEvent(101, 2)
                    end
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    if option == 1 then
                        -- Start run
                        player:needToZone(true)
                        mission:setLocalVar(player, '[p3]timeLimit', os.time() + utils.minutes(8))
                        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 1, 0, 0)

                        -- https://www.bg-wiki.com/ffxi/Kupo_Mission_13 : "The effect durations are random. They can be 3-7 minutes long. "
                        local buffDuration = math.floor(utils.minutes(math.random(3, 7)) * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER)
                        player:addStatusEffect(xi.effect.INVISIBLE, 1, 10, buffDuration)
                        player:addStatusEffect(xi.effect.DEODORIZE, 1, 10, buffDuration)
                        player:addStatusEffect(xi.effect.SNEAK, 1, 10, buffDuration)
                    elseif option == 2 then
                        -- Player came back to refresh buffs
                        local buffDuration = math.floor(utils.minutes(math.random(3, 7)) * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER)
                        player:addStatusEffect(xi.effect.INVISIBLE, 1, 10, buffDuration)
                        player:addStatusEffect(xi.effect.DEODORIZE, 1, 10, buffDuration)
                        player:addStatusEffect(xi.effect.SNEAK, 1, 10, buffDuration)
                    end
                end,

                [101] = function(player, csid, option, npc)
                    if option == 1 then
                        -- Won the game!
                        npcUtil.giveKeyItem(player, xi.ki.FESTIVAL_SOUVENIR_KUPON)
                        player:delKeyItem(xi.ki.GAUNTLET_CHALLENGE_KUPON)

                        -- Advance to puzzle 4
                        mission:setVar(player, 'progress', 4)
                    end

                    if mission:getLocalVar(player, '[p3]timeLimit') > 0 then
                        player:setMP(player:getMaxMP())
                        player:setHP(player:getMaxHP())
                        mission:setLocalVar(player, '[p3]timeLimit', 0)
                    end
                end,
            },
        },
    },

    -- Part 5: Castle Zvahl Keep - Puzzle 4
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId and
                mission:getVar(player, 'progress') == 4 and
                player:hasKeyItem(xi.ki.FESTIVAL_SOUVENIR_KUPON)
        end,

        [xi.zone.CASTLE_ZVAHL_BAILEYS] =
        {
            ['Flame_of_Fate'] =
            {
                onTrigger = function(player, npc)
                    -- Reminder text
                    return mission:progressEvent(101, 3)
                end,
            },
        },

        [xi.zone.CASTLE_ZVAHL_KEEP] =
        {
            ['Ominous_Pillar'] =
            {
                onTrigger = function(player, npc)
                    local correctCohortIdx = mission:getVar(player, 'cohortIdx')
                    local eventArg = 2

                    if correctCohortIdx == 0 then
                        correctCohortIdx = math.random(1, 4)
                        -- Save cohort temporarily
                        npc:setLocalVar('cohortIdx', correctCohortIdx)
                        eventArg = 1
                    end

                    return mission:progressEvent(100, eventArg, correctCohortIdx - 1)
                end,
            },

            ['Craggy_Pillar'] =
            {
                onTrigger = function(player, npc)
                    local craggyPillars = zones[player:getZoneID()].npc.CRAGGY_PILLAR
                    local cohorts =
                    {
                        [craggyPillars[1]] = { eventID = 101, cohortIdx = 1, location = 0 }, -- Kupignol
                        [craggyPillars[2]] = { eventID = 102, cohortIdx = 3, location = 1 }, -- Kupert
                        [craggyPillars[3]] = { eventID = 103, cohortIdx = 2, location = 2 }, -- Kupuckl
                        [craggyPillars[4]] = { eventID = 104, cohortIdx = 0, location = 3 }, -- Kupatete
                    }
                    local correctCohortIdx = mission:getVar(player, 'cohortIdx') - 1
                    local result = 2 -- Wrong answer
                    local crag = cohorts[npc:getID()]

                    if crag.cohortIdx == correctCohortIdx then
                        result = 1 -- Correct answer
                    end

                    if correctCohortIdx >= 0 then
                        return mission:progressEvent(crag.eventID, result, crag.cohortIdx, 1, crag.location, correctCohortIdx)
                    else
                        return mission:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
                    end
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    if option ~= 0 then
                        mission:setVar(player, 'cohortIdx', npc:getLocalVar('cohortIdx'))
                    end
                end,

                [101] = function(player, csid, option, npc)
                    xi.amk.helpers.puzzleFourOnEventFinish(player, csid, option, npc, mission)
                end,

                [102] = function(player, csid, option, npc)
                    xi.amk.helpers.puzzleFourOnEventFinish(player, csid, option, npc, mission)
                end,

                [103] = function(player, csid, option, npc)
                    xi.amk.helpers.puzzleFourOnEventFinish(player, csid, option, npc, mission)
                end,

                [104] = function(player, csid, option, npc)
                    xi.amk.helpers.puzzleFourOnEventFinish(player, csid, option, npc, mission)
                end,
            },
        },
    },

    -- Part 6: Throne Room - Cutscene
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
            mission:getVar(player, 'progress') == 5 and
            player:hasKeyItem(xi.ki.MEGA_BONANZA_KUPON)
        end,

        [xi.zone.THRONE_ROOM] =
        {
            ['_4l1'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(4, 165)
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
