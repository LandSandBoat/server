-----------------------------------
-- A Challenge! You Could Be a Winner
-- A Moogle Kupo d'Etat M13
-- !addmission 10 12
-- Shadowy Pillar : !pos 374 -12 -15
-- Lonely Evergreen : !pos -162 -80 178
-- Goblin Grenadier : !pos -26 -59 -76
-----------------------------------
-- This mission can be repeated by losing the bncm battle in the subsequent mission
-- Therefore to remove possible conflicts, the mission progress will be handled
-- using a variable stored as a CharVar
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
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
                    player:setCharVar('Mission[10][12]progress', 1)
                end,
            },
        },
    },

    -- Part 2-a: Beaucedine Glacier
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId and
            player:getCharVar('Mission[10][12]progress') == 1 and
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
                    if option == 1 then
                        player:needToZone(true)
                    end
                end,
            },
        },
    },

    -- Part 2-b: Beaucedine Glacier
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId and
            player:getCharVar('Mission[10][12]progress') == 1 and
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
                    local answer = player:getLocalVar('Mission[10][12][p1]pipSet') - 1

                    if answer < 0 then
                        return mission:progressEvent(508, xi.ki.MAP_OF_THE_NORTHLANDS_AREA)
                    else
                        local today = VanadielDayOfTheWeek()
                        local tomorrow = (today + 1) % 8
                        local hintsUsed = player:getLocalVar('Mission[10][12][p1]hintsUsed')

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
                        local hintsUsed = player:getLocalVar('Mission[10][12][p1]hintsUsed')
                        player:setLocalVar('Mission[10][12][p1]hintsUsed', hintsUsed + 1)
                    elseif option == 3 then
                        -- wrong answer, reset puzzle
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
                    player:setLocalVar('Mission[10][12][p1]pipSet', math.random(1, 10)) -- range: 0 - 9
                end,
            },
        },
    },

    -- Part 2-c: Beaucedine Glacier
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId and
            player:getCharVar('Mission[10][12]progress') == 1 and
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
                    player:setCharVar('Mission[10][12]progress', 2)
                end,
            },
        },
    },

    -- Part 3: Xarcabard
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId and
            player:getCharVar('Mission[10][12]progress') == 2 and
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

    -- Part 4: Castle Zvahl Baileys
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CASTLE_ZVAHL_BAILEYS] =
        {

        },
    },

    -- Part 5: Castle Zvahl Keep
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CASTLE_ZVAHL_KEEP] =
        {

        },
    },
}

return mission
