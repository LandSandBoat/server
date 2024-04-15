-----------------------------------
-- An Explorer's Footsteps
-----------------------------------
-- Log ID: 4, Quest ID: 19
-- This quest was changed to require a minimum amount of fame to combat RMTs POS-Hacking around to
-- quickly earn gil. However, as this is not a legitimate concern on private servers players may
-- complete this quest even with no fame.
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.AN_EXPLORER_S_FOOTSTEPS)

local payOut =
{
    800, -- West Ronfaure -- !gotoid 17187513
    800, -- East Ronfaure -- !gotoid 17191526
    1000, -- La Theine Plateau -- !gotoid 17195621
    1000, -- Valkurm Dunes -- !gotoid 17199698
    1000, -- Jugner Forest -- !gotoid 17203814
    10000, -- Batallia Downs -- !gotoid 17207821
    3000, -- North Gustaberg -- !gotoid 17212049
    800, -- South Gustaberg -- !gotoid 17216174
    1000, -- Konschtat Highlands -- !gotoid 17220150
    1000, -- Pashhow Marshlands -- !gotoid 17224302
    3000, -- Rolanberry Fields -- !gotoid 17228353
    800, -- West Sarutabaruta -- !gotoid 17248818
    800, -- East Sarutabaruta -- !gotoid 17253064
    1000, -- Tahrongi Canyon -- !gotoid 17257053
    1000, -- Buburimu Peninsula -- !gotoid 17261140
    1000, -- Meriphataud Mountains -- !gotoid 17265242
    10000, -- Sauromugue Champaign -- !gotoid 17269222
}

local function handleTabletTurnInEvent(player, csid, option)
    player:confirmTrade()
    npcUtil.giveCurrency(player, 'gil', payOut[quest:getVar(player, 'currentTablet')])
    if quest:countSetVarBits(player, 'tabletsTurnedIn') == 15 then
        npcUtil.giveKeyItem(player, xi.ki.MAP_OF_THE_CRAWLERS_NEST)
    end

    if option == 100 then -- player asked if he/she wants to keep looking for stone monuments and chooses to keep looking
        npcUtil.giveItem(player, xi.item.LUMP_OF_SELBINA_CLAY)
        quest:setVar(player, 'choseNotToSearch', 0)
    elseif option == 110 then -- player asked if he/she wants to keep looking for stone monuments and declines to keep looking
        quest:setVar(player, 'choseNotToSearch', 1)
    end

    if csid == 47 then
        quest:complete(player)
    end

    quest:setVar(player, 'currentTablet', 0) -- removing variable since player should no longer have a tablet
end

local function handleStoneMonumentTrade (player, npc, trade, currentTablet)
    if npcUtil.tradeHasExactly(trade, xi.item.LUMP_OF_SELBINA_CLAY) then
        player:confirmTrade()
        npcUtil.giveItem(player, xi.item.CLAY_TABLET)
        quest:setVar(player, 'currentTablet', currentTablet)
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getFameLevel(xi.quest.fame_area.SELBINA_RABAO) >= 1 --unsure where they are getting rabao fame from
        end,

        [xi.zone.SELBINA] =
        {
            ['Abelard'] = quest:event(40),

            onEventFinish =
            {
                [40] = function(player, csid, option, npc)
                    if option == 100 then --player answers 'of course.' to agree to do the quest
                        npcUtil.giveItem(player, xi.item.LUMP_OF_SELBINA_CLAY)
                        quest:begin(player)
                        quest:setVar(player, 'requestedTablet', 1) --he initially asks for tablet from West Ronfaure
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WEST_RONFAURE] =
        {
            ['Stone_Monument'] =
            {
                onTrade = function(player, npc, trade)
                    handleStoneMonumentTrade(player, npc, trade, 1)
                end,
            },
        },

        [xi.zone.EAST_RONFAURE] =
        {
            ['Stone_Monument'] = {
                onTrade = function(player, npc, trade)
                    handleStoneMonumentTrade(player, npc, trade, 2)
                end,
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Stone_Monument'] = {
                onTrade = function(player, npc, trade)
                    handleStoneMonumentTrade(player, npc, trade, 3)
                end,
            },
        },

        [xi.zone.VALKURM_DUNES] =
        {
            ['Stone_Monument'] = {
                onTrade = function(player, npc, trade)
                    handleStoneMonumentTrade(player, npc, trade, 4)
                end,
            },
        },

        [xi.zone.JUGNER_FOREST] =
        {
            ['Stone_Monument'] = {
                onTrade = function(player, npc, trade)
                    handleStoneMonumentTrade(player, npc, trade, 5)
                end,
            },
        },

        [xi.zone.BATALLIA_DOWNS] =
        {
            ['Stone_Monument'] = {
                onTrade = function(player, npc, trade)
                    handleStoneMonumentTrade(player, npc, trade, 6)
                end,
            },
        },

        [xi.zone.NORTH_GUSTABERG] =
        {
            ['Stone_Monument'] = {
                onTrade = function(player, npc, trade)
                    handleStoneMonumentTrade(player, npc, trade, 7)
                end,
            },
        },

        [xi.zone.SOUTH_GUSTABERG] =
        {
            ['Stone_Monument'] = {
                onTrade = function(player, npc, trade)
                    handleStoneMonumentTrade(player, npc, trade, 8)
                end,
            },
        },

        [xi.zone.KONSCHTAT_HIGHLANDS] =
        {
            ['Stone_Monument'] = {
                onTrade = function(player, npc, trade)
                    handleStoneMonumentTrade(player, npc, trade, 9)
                end,
            },
        },

        [xi.zone.PASHHOW_MARSHLANDS] =
        {
            ['Stone_Monument'] = {
                onTrade = function(player, npc, trade)
                    handleStoneMonumentTrade(player, npc, trade, 10)
                end,
            },
        },

        [xi.zone.ROLANBERRY_FIELDS] =
        {
            ['Stone_Monument'] = {
                onTrade = function(player, npc, trade)
                    handleStoneMonumentTrade(player, npc, trade, 11)
                end,
            },
        },

        [xi.zone.WEST_SARUTABARUTA] =
        {
            ['Stone_Monument'] = {
                onTrade = function(player, npc, trade)
                    handleStoneMonumentTrade(player, npc, trade, 12)
                end,
            },
        },

        [xi.zone.EAST_SARUTABARUTA] =
        {
            ['Stone_Monument'] = {
                onTrade = function(player, npc, trade)
                    handleStoneMonumentTrade(player, npc, trade, 13)
                end,
            },
        },

        [xi.zone.TAHRONGI_CANYON] =
        {
            ['Stone_Monument'] = {
                onTrade = function(player, npc, trade)
                    handleStoneMonumentTrade(player, npc, trade, 14)
                end,
            },
        },

        [xi.zone.BUBURIMU_PENINSULA] =
        {
            ['Stone_Monument'] = {
                onTrade = function(player, npc, trade)
                    handleStoneMonumentTrade(player, npc, trade, 15)
                end,
            },
        },

        [xi.zone.MERIPHATAUD_MOUNTAINS] =
        {
            ['Stone_Monument'] = {
                onTrade = function(player, npc, trade)
                    handleStoneMonumentTrade(player, npc, trade, 16)
                end,
            },
        },

        [xi.zone.SAUROMUGUE_CHAMPAIGN] =
        {
            ['Stone_Monument'] = {
                onTrade = function(player, npc, trade)
                    handleStoneMonumentTrade(player, npc, trade, 17)
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Abelard'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasItem(xi.item.CLAY_TABLET) and
                        not player:hasItem(xi.item.LUMP_OF_SELBINA_CLAY)
                    then
                        if quest:getVar(player, 'choseNotToSearch') == 1 then
                            return quest:event(42) -- player declined to start looking for monuments when asked after turning in last clay tablet - ask player if he/she wants to start searching again
                        else
                            return quest:event(44) -- player dropped their clay and needs it to progress quest - give player another lump of selbina clay
                        end

                    else -- remind player of a monument to go to
                        local tabletStatus = {} -- make list of which tablets are turned in nd which aren't
                        for i = 0, 16 do
                            tabletStatus[i + 1] = quest:isVarBitsSet(player, 'tabletsTurnedIn', i)
                        end

                        local monumentsNotTurnedIn = {} -- in the following loop we push values to this table for places not yet visited -- need them to pick cutscene 43 or 49 later on
                        for bitNum, isSet in ipairs(tabletStatus) do
                            if not isSet then
                                table.insert(monumentsNotTurnedIn, bitNum)
                            end
                        end

                        local monumentToGoTo = monumentsNotTurnedIn[1] -- pick first location player hasn't yet turned in a clay tablet for
                        quest:setVar(player, 'requestedTablet', monumentToGoTo)
                        if monumentToGoTo < 10 then -- give player reminder of where stone monuments are. He will tell the player a new monument (that you haven't been to) that's lowest on payout table
                            return quest:event(43, monumentToGoTo - 1) -- why 49 is for some CS and 43 for other is beyond me
                        else
                            return quest:event(49, monumentToGoTo - 10)
                        end
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.CLAY_TABLET) then
                        if quest:isVarBitsSet(player, 'tabletsTurnedIn', quest:getVar(player, 'currentTablet') - 1) then -- player had already turned in a clay tablet from the stone monument they are trying to turn in. Not sure if retail has them keep the clay tablet or makes them drop it.
                            player:tradeComplete(false)
                            return quest:event(45)
                        end

                        local currentTablet = quest:getVar(player, 'currentTablet')
                        quest:setVarBit(player, 'tabletsTurnedIn', currentTablet - 1) -- we need to keep track of which tablets are turned in to tell player which monument to go to next and how many are turned in(for the reward)

                        if quest:countSetVarBits(player, 'tabletsTurnedIn') == 17 then -- all tablets turned in - complete quest
                            return quest:event(47)
                        end

                        if quest:getVar(player, 'requestedTablet') == quest:getVar(player, 'currentTablet') then -- turn in a tablet
                            return quest:event(41) -- the tablet he asked for
                        else
                            return quest:event(46) -- not the one he asked for
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [42] = function(player, csid, option, npc)
                    if option == 100 then -- player said they want to start searching for stone monuments
                        npcUtil.giveItem(player, xi.item.LUMP_OF_SELBINA_CLAY)
                        quest:setVar(player, 'choseNotToSearch', 0)
                        quest:setVar(player, 'currentTablet', 0) -- setting to nil out of abundance of caution - player should not have any stone monument tablet
                    end
                end,

                [44] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.item.LUMP_OF_SELBINA_CLAY)
                    quest:setVar(player, 'currentTablet', 0) -- setting to nil out of abundance of caution - player should not have any stone monument tablet
                end,

                [41] = function(player, csid, option, npc)
                    handleTabletTurnInEvent(player, csid, option)
                end,

                [46] = function(player, csid, option, npc)
                    handleTabletTurnInEvent(player, csid, option)
                end,

                [47] = function(player, csid, option, npc)
                    handleTabletTurnInEvent(player, csid, option)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.SELBINA] =
        {
            ['Abelard'] =
            {
            onTrigger = function(player, npc)
                return quest:event(48):replaceDefault()
            end,

            },
        },
    },
}

return quest
