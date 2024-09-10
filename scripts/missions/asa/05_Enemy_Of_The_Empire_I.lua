-----------------------------------
-- A Shantotto Ascension
-- A Shantotto Ascension M5
-----------------------------------
-- !addmission 11 4
-- Andrause : !pos 22.72 -5.13 18.51 252
-----------------------------------
local norgID = zones[xi.zone.NORG]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_I)

mission.reward =
{
    ki = xi.ki.BLACK_BOOK,
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_II },
}

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
    { 'Sahagin Parasite', 'SahaginParasitd' },
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

local function handleTradeEvent(player, trade)
    local mobOne = mission:getVar(player, 'MobOne')

    -- Trading Soul Plates
    if mobOne ~= 0 and npcUtil.tradeHasExactly(trade, xi.item.SOUL_PLATE) then
        local mobTwo = mission:getVar(player, 'MobTwo')
        local mobThree = mission:getVar(player, 'MobThree')
        local platesTraded = mission:getVar(player, 'Plates')
        local item = trade:getItem(0)
        local plateData = item:getSoulPlateData()

        -- Check if traded Soulplate is one of the requested mobs
        for value, data in pairs(mobList) do
            if data[2] == plateData.name then
                mission:setVar(player, 'Found', value)
                mission:setVar(player, 'Plates', platesTraded + 1)

                -- Assign 99 to traded mob's var to mark it as completed
                if value == mobOne then
                    mission:setVar(player, 'MobOne', 99)
                elseif value == mobTwo then
                    mission:setVar(player, 'MobTwo', 99)
                elseif value == mobThree then
                    mission:setVar(player, 'MobThree', 99)
                end

                player:confirmTrade()
                return mission:progressEvent(241)
            end
        end

        -- Wrong soulplate traded
        return mission:progressEvent(242)
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['Andrause'] =
            {
                onTrigger = function(player, npc)
                    local mobCheck = mission:getVar(player, 'MobOne')
                    local platesTraded = mission:getVar(player, 'Plates')

                    if not player:hasKeyItem(xi.ki.BLACK_BOOK) then
                        -- Select mobs for player to get pictures of
                        if mobCheck == 0 then
                            local mobOne, MobTwo, mobThree = unpack(utils.uniqueRandomTable(1, 23, 3))

                            mission:setVar(player, 'MobOne', mobOne)
                            mission:setVar(player, 'MobTwo', MobTwo)
                            mission:setVar(player, 'MobThree', mobThree)

                            return mission:progressEvent(237)
                        -- Tell player what mobs are still needed
                        elseif mobCheck ~= 0 and platesTraded == 0 then
                            return mission:progressEvent(238, 3)
                        elseif mobCheck ~= 0 and platesTraded == 1 then
                            return mission:progressEvent(238, 2)
                        elseif mobCheck ~= 0 and platesTraded == 2 then
                            return mission:progressEvent(238, 1)
                        end
                    elseif player:hasKeyItem(xi.ki.BLACK_BOOK) then
                        return mission:progressEvent(240)
                    end
                end,

                onTrade = function(player, npc, trade)
                    return handleTradeEvent(player, trade)
                end,
            },

            onEventUpdate =
            {
                -- Handle telling player what mobs to get pictures of and selling Soultrapper + Plates
                -- event 237
                -- option 2 = yes, ill do it
                -- option 5 = buy the camera, doesnt appear to be a 'not enough gil dialogue'
                [237] = function(player, csid, option, npc)
                    local mobOne = mission:getVar(player, 'MobOne')
                    local mobTwo = mission:getVar(player, 'MobTwo')
                    local mobThree = mission:getVar(player, 'MobThree')

                    if option == 4 then
                        player:updateEvent(xi.item.SOULTRAPPER, xi.item.BLANK_SOUL_PLATE, 2477)
                    elseif option == 1 then
                        player:updateEventString(mobList[mobOne][1], mobList[mobTwo][1], mobList[mobThree][1], '', 49284, 524420, 0, 0, 0, 0, 0, 0)
                    elseif option == 6 then
                        -- Param 0 = allowed to buy a camera, >0 = 'im out of stock'
                        -- param 3 = x .:(You have x) (maybe number of blank plates?)
                        player:updateEvent(0, xi.item.SOULTRAPPER, xi.item.BLANK_SOUL_PLATE, player:getGil())
                    elseif option == 5 then
                        mission:setVar(player, 'AndrauseBuy', 1)
                    end
                end,

                -- Tell the player what mobs are still needed
                [238] = function(player, csid, option, npc)
                    local mobOne = mission:getVar(player, 'MobOne')
                    local mobTwo = mission:getVar(player, 'MobTwo')
                    local mobThree = mission:getVar(player, 'MobThree')
                    local pickupReady = mission:getVar(player, 'Soulplate') < os.time()
                    local platesTraded = mission:getVar(player, 'Plates')

                    if option == 6 then
                        if platesTraded == 0 then
                            player:updateEventString(mobList[mobOne][1], mobList[mobTwo][1], mobList[mobThree][1])
                        -- 99 = Player completed trade
                        elseif platesTraded == 1 then
                            if mobOne == 99 then
                                player:updateEventString(mobList[mobTwo][1], mobList[mobThree][1])
                            elseif mobTwo == 99 then
                                player:updateEventString(mobList[mobOne][1], mobList[mobThree][1])
                            elseif mobThree == 99 then
                                player:updateEventString(mobList[mobOne][1], mobList[mobTwo][1])
                            end
                        elseif platesTraded == 2 then
                            if mobOne == 99 and mobTwo == 99 then
                                player:updateEventString(mobList[mobThree][1])
                            elseif mobTwo == 99 and mobThree == 99 then
                                player:updateEventString(mobList[mobOne][1])
                            elseif mobOne == 99 and mobThree == 99 then
                                player:updateEventString(mobList[mobTwo][1])
                            end
                        end

                        if pickupReady then
                            player:updateEvent(0, xi.item.SOULTRAPPER, xi.item.BLANK_SOUL_PLATE, player:getGil())
                        end
                    elseif option == 4 then
                        player:updateEvent(xi.item.SOULTRAPPER, xi.item.BLANK_SOUL_PLATE)
                    elseif option == 5 then
                        mission:setVar(player, 'AndrauseBuy', 1)
                    end
                end,

                -- Player traded a soulplate correctly, tell them what mobs are still needed
                [241] = function(player, csid, option, npc)
                    local mobOne = mission:getVar(player, 'MobOne')
                    local mobTwo = mission:getVar(player, 'MobTwo')
                    local mobThree = mission:getVar(player, 'MobThree')
                    local platesTraded = mission:getVar(player, 'Plates')

                    local foundMob = mission:getVar(player, 'Found')
                    if platesTraded == 1 then
                        -- 99 = Player traded correct plate for requested mob
                        if mobOne == 99 then
                            player:updateEvent(0, 3)
                            player:updateEventString(mobList[foundMob][1], mobList[mobTwo][1], mobList[mobThree][1])
                        elseif mobTwo == 99 then
                            player:updateEvent(0, 3)
                            player:updateEventString(mobList[foundMob][1], mobList[mobOne][1], mobList[mobThree][1])
                        elseif mobThree == 99 then
                            player:updateEvent(0, 3)
                            player:updateEventString(mobList[foundMob][1], mobList[mobOne][1], mobList[mobTwo][1])
                        end
                    elseif platesTraded == 2 then
                        if mobOne == 99 and mobTwo == 99 then
                            player:updateEvent(0, 2)
                            player:updateEventString(mobList[foundMob][1], mobList[mobThree][1])
                        elseif mobTwo == 99 and mobThree == 99 then
                            player:updateEvent(0, 2)
                            player:updateEventString(mobList[foundMob][1], mobList[mobOne][1])
                        elseif mobOne == 99 and mobThree == 99 then
                            player:updateEvent(0, 2)
                            player:updateEventString(mobList[foundMob][1], mobList[mobTwo][1])
                        end
                    elseif platesTraded == 3 then
                        player:updateEvent(0, 1)
                        player:updateEventString(mobList[foundMob][1])
                    end
                end,
            },

            onEventFinish =
            {
                -- Give player Soultrapper + Plates
                [237] = function(player, csid, option, npc)
                    if mission:getVar(player, 'AndrauseBuy') == 1 and player:getGil() > 800 then
                        player:delGil(800)
                        if not player:hasItem(xi.item.SOULTRAPPER) then
                            npcUtil.giveItem(player, xi.item.SOULTRAPPER)
                        end

                        npcUtil.giveItem(player, { xi.item.SOULTRAPPER, 12 })
                        mission:setVar(player, 'AndrauseBuy', 0)
                        mission:setVar(player, 'Soulplate', getMidnight())
                    elseif mission:getVar(player, 'AndrauseBuy') == 1 and player:getGil() < 800 then
                        mission:setVar(player, 'AndrauseBuy', 0)
                    end
                end,

                -- Give player Soultrapper + Plates
                [238] = function(player, csid, option, npc)
                    if mission:getVar(player, 'AndrauseBuy') == 1 and player:getGil() > 800 then
                        player:delGil(800)
                        if not player:hasItem(xi.item.SOULTRAPPER) then
                            player:addItem(xi.item.SOULTRAPPER)
                            player:messageSpecial(norgID.text.ITEM_OBTAINED, xi.item.SOULTRAPPER) -- Soultrapper
                        end

                        player:addItem(xi.item.BLANK_SOUL_PLATE, 12)
                        player:messageSpecial(norgID.text.YOU_OBTAIN, xi.item.BLANK_SOUL_PLATE, 12) -- Soul Plates
                        mission:setVar(player, 'AndrauseBuy', 0)
                        mission:setVar(player, 'Soulplate', getMidnight())
                    elseif mission:getVar(player, 'AndrauseBuy') == 1 and player:getGil() < 800 then
                        mission:setVar(player, 'AndrauseBuy', 0)
                    end
                end,

                -- Player finished all three plates, give them the KI and complete mission
                [241] = function(player, csid, option, npc)
                    local platesTraded = mission:getVar(player, 'Plates')
                    if platesTraded == 3 then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
