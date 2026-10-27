-----------------------------------
-- Enemy Of The Empire I
-- A Shantotto Ascension M5
-----------------------------------
-- !addmission 11 4
-- Andrause    : !pos 22.72 -5.13 18.51 252
-- Outcropping : !pos -134.658 -11.366 -185.2 212
-- BLACK_BOOK  : !addkeyitem 1203
-----------------------------------
local norgID = zones[xi.zone.NORG]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_I)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_II },
}

-- Mob names as the client shows them, and the signature the Soultrapper writes on the plate.
local mobList =
{
    { 'Bigclaw',          'Bigclaw'         },
    { 'Brook Sahagin',    'BrookSahagin'    },
    { 'Riparian Sahagin', 'RiparianSahagin' },
    { 'Rivulet Sahagin',  'RivuletSahagin'  },
    { 'Royal Leech',      'RoyalLeech'      },
    { 'Undead Bats',      'UndeadBats'      },
    { 'Grotto Pugil',     'GrottoPugil'     },
    { 'Sea Bonze',        'SeaBonze'        },
    { 'Blubber Eyes',     'BlubberEyes'     },
    { 'Bog Sahagin',      'BogSahagin'      },
    { 'Marsh Sahagin',    'MarshSahagin'    },
    { 'Rock Crab',        'RockCrab'        },
    { 'Razorjaw Pugil',   'RazorjawPugil'   },
    { 'Sahagin Parasite', 'SahaginParasite' },
    { 'Swamp Sahagin',    'SwampSahagin'    },
    { 'Devil Manta',      'DevilManta'      },
    { 'Dire Bat',         'DireBat'         },
    { 'Lagoon Sahagin',   'LagoonSahagin'   },
    { 'Delta Sahagin',    'DeltaSahagin'    },
    { 'Coastal Sahagin',  'CoastalSahagin'  },
    { 'Mousse',           'Mousse'          },
    { 'Robber Crab',      'RobberCrab'      },
    { 'Shore Sahagin',    'ShoreSahagin'    },
}

local mobVars = { 'MobOne', 'MobTwo', 'MobThree' }

-- The mobs still wanted, in slot order. 99 marks a delivered plate. The plate in hand (Pending) is left out too.
local function remainingMobs(player)
    local pending = mission:getVar(player, 'Pending')
    local names   = {}
    for slot, var in ipairs(mobVars) do
        local index = mission:getVar(player, var)
        if index ~= 0 and index ~= 99 and slot ~= pending then
            table.insert(names, mobList[index][1])
        end
    end

    return names
end

-- The event wants three strings. Retail leaves unused slots stale, so any filler will do.
local function padNames(names)
    local padded = {}
    for i = 1, 3 do
        padded[i] = names[math.min(i, #names)] or ''
    end

    return padded
end

-- Outside the mission prefix so completing the mission does not clear the restock time.
local stockVar = '[ASA]SoultrapperRestock'

-- Options: 1 the wanted mobs, 2 accept, 4 explain the Soultrapper, 5 buy, 6 stock check.
local function shopOptions(player, csid, option, npc)
    if option == 1 then
        player:updateEventString(unpack(padNames(remainingMobs(player))))
        player:updateEvent(0, xi.item.BLANK_SOUL_PLATE, xi.item.SOUL_PLATE)
    elseif option == 2 then
        player:updateEvent(0, xi.item.SOULTRAPPER, xi.item.BLANK_SOUL_PLATE)
    elseif option == 4 then
        player:updateEvent(xi.item.SOULTRAPPER, xi.item.BLANK_SOUL_PLATE, xi.item.SOUL_PLATE)
    elseif option == 5 then
        -- The Soultrapper and twelve plates for 800 gil, once a day.
        -- TODO: Capture needed, the restock at Japanese midnight and the reply when the player cannot buy are guesses.
        if
            player:getCharVar(stockVar) > GetSystemTime() or
            player:getGil() < 800 or
            player:getFreeSlotsCount() < 2 or
            not player:addItem(xi.item.SOULTRAPPER)
        then
            player:updateEvent(0)
            return
        end

        if not player:addItem(xi.item.BLANK_SOUL_PLATE, 12) then
            player:delItem(xi.item.SOULTRAPPER)
            player:updateEvent(0)
            return
        end

        player:messageSpecial(norgID.text.ITEM_OBTAINED, xi.item.SOULTRAPPER)
        player:messageSpecial(norgID.text.YOU_OBTAIN, xi.item.BLANK_SOUL_PLATE, 12)
        player:delGil(800)
        player:setCharVar(stockVar, JstMidnight(), JstMidnight())
        player:updateEvent(xi.item.BLANK_SOUL_PLATE, 12)
    elseif option == 6 then
        player:updateEvent(player:getCharVar(stockVar) > GetSystemTime() and 1 or 0, xi.item.SOULTRAPPER, xi.item.BLANK_SOUL_PLATE, player:getGil())
    end
end

mission.sections =
{
    -- Andrause hands out black books after the mission too, so the Gustav Tunnel fight can be repeated.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['Andrause'] =
            {
                onTrade = function(player, npc, trade)
                    if mission:getVar(player, 'MobOne') == 0 then
                        return
                    end

                    mission:setVar(player, 'Pending', 0)

                    if not npcUtil.tradeMatches(trade, { { xi.item.SOUL_PLATE, 1 } }) then
                        return
                    end

                    local plateData = trade:getItem(0):getExData()

                    for slot, var in ipairs(mobVars) do
                        local index = mission:getVar(player, var)
                        if index ~= 99 and mobList[index][2] == plateData.signature then
                            -- The plate is only counted once the event finishes and takes it.
                            mission:setVar(player, 'Pending', slot)

                            local names = padNames(utils.appendArrays({ mobList[index][1] }, remainingMobs(player)))
                            player:startEventString(241, names[1], names[2], names[3], '', player:hasCompletedMission(mission.areaId, mission.missionId) and 1 or 0)
                            return mission:noAction()
                        end
                    end

                    return mission:progressEvent(242)
                end,

                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.keyItem.BLACK_BOOK) then
                        return mission:event(240)
                    end

                    mission:setVar(player, 'Pending', 0)

                    if mission:getVar(player, 'MobOne') == 0 then
                        local picks = utils.uniqueRandomTable(1, #mobList, 3)
                        mission:setVar(player, 'MobOne', picks[1])
                        mission:setVar(player, 'MobTwo', picks[2])
                        mission:setVar(player, 'MobThree', picks[3])
                        mission:setVar(player, 'Plates', 0)

                        player:startEventString(237, '', '', '', '', player:hasCompletedMission(mission.areaId, mission.missionId) and 1 or 0, xi.item.SOULTRAPPER, xi.item.BLANK_SOUL_PLATE)
                        return mission:noAction()
                    end

                    local names = padNames(remainingMobs(player))
                    player:startEventString(238, names[1], names[2], names[3], '', 3 - mission:getVar(player, 'Plates'))
                    return mission:noAction()
                end,
            },

            onEventUpdate =
            {
                [237] = shopOptions,
                [238] = shopOptions,

                -- Options: 7 the opening line, 8 and 3 the plates still wanted including this one.
                -- TODO: Capture needed, retail also sends a first param on 8 and a second on 3.
                [241] = function(player, csid, option, npc)
                    local remaining = #remainingMobs(player) + 1

                    if option == 7 then
                        player:updateEvent(player:hasCompletedMission(mission.areaId, mission.missionId) and 1 or 0)
                    elseif option == 8 then
                        player:updateEvent(0, remaining)
                    elseif option == 3 then
                        player:updateEvent(remaining)
                    end
                end,
            },

            onEventFinish =
            {
                [241] = function(player, csid, option, npc)
                    local pending = mission:getVar(player, 'Pending')
                    if pending == 0 then
                        return
                    end

                    mission:setVar(player, 'Pending', 0)
                    if not player:tradeComplete() then
                        return
                    end

                    mission:setVar(player, mobVars[pending], 99)
                    mission:incrementVar(player, 'Plates', 1)

                    if mission:getVar(player, 'Plates') == 3 then
                        for _, var in ipairs(mobVars) do
                            mission:setVar(player, var, 0)
                        end

                        mission:setVar(player, 'Plates', 0)
                        npcUtil.giveKeyItem(player, xi.keyItem.BLACK_BOOK)
                    end
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.GUSTAV_TUNNEL] =
        {
            ['Outcropping'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.keyItem.BLACK_BOOK) then
                        return mission:progressEvent(13)
                    end
                end,
            },

            onEventFinish =
            {
                [13] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
