-----------------------------------
-- An Explorer's Footsteps
-----------------------------------
-- Log ID: 4, Quest ID: 19
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.AN_EXPLORERS_FOOTSTEPS)

local monumentTable =
{
    [xi.zone.WEST_RONFAURE        ] = {  0,   800 }, -- !pos -183.734 -12.6798 -395.7220 100
    [xi.zone.EAST_RONFAURE        ] = {  1,   800 }, -- !pos   77.277  -2.894  -517.3760 101
    [xi.zone.LA_THEINE_PLATEAU    ] = {  2,  1000 }, -- !pos  334.133  50.6223  141.1630 102
    [xi.zone.VALKURM_DUNES        ] = {  3,  1000 }, -- !pos -311.299  -4.4211 -138.8780 103
    [xi.zone.JUGNER_FOREST        ] = {  4,  1000 }, -- !pos  -65.976 -23.8312 -661.3620 104
    [xi.zone.BATALLIA_DOWNS       ] = {  5, 10000 }, -- !pos  185.669   9.0476 -614.0250 105
    [xi.zone.NORTH_GUSTABERG      ] = {  6,  3000 }, -- !pos -199.635  96.0547  505.6240 106
    [xi.zone.SOUTH_GUSTABERG      ] = {  7,   800 }, -- !pos  520.064  -5.8831 -738.3560 107
    [xi.zone.KONSCHTAT_HIGHLANDS  ] = {  8,  1000 }, -- !pos -102.355   7.9796  253.7059 108
    [xi.zone.PASHHOW_MARSHLANDS   ] = {  9,  1000 }, -- !pos -300.672  21.6038  304.1790 109
    [xi.zone.ROLANBERRY_FIELDS    ] = { 10,  3000 }, -- !pos  362.479 -34.8962 -398.9940 110
    [xi.zone.WEST_SARUTABARUTA    ] = { 11,   800 }, -- !pos -205.593 -23.2401 -119.6700 115
    [xi.zone.EAST_SARUTABARUTA    ] = { 12,   800 }, -- !pos  448.045  -7.8100  319.9799 116
    [xi.zone.TAHRONGI_CANYON      ] = { 13,  1000 }, -- !pos -499.189  12.6524  373.5920 117
    [xi.zone.BUBURIMU_PENINSULA   ] = { 14,  1000 }, -- !pos  320.755  -4.0779  368.7219 118
    [xi.zone.MERIPHATAUD_MOUNTAINS] = { 15,  1000 }, -- !pos  450.741   2.1088 -290.7359 119
    [xi.zone.SAUROMUGUE_CHAMPAIGN ] = { 16, 10000 }, -- !pos   77.544  -2.7476 -184.8030 120
}

local function abelardAccept(player, option)
    if option == 100 then
        if npcUtil.giveItem(player, xi.item.LUMP_OF_SELBINA_CLAY) then
            player:setLocalVar('[EF]ClayRecieved', 1)

            -- Decide monument to request.
            local monumentBitmask = player:getCharVar('[EF]MonumentBitmask')

            for i = 0, 16 do
                if not utils.mask.getBit(monumentBitmask, i) then
                    quest:setVar(player, '[EF]TargetMonument', i)

                    break
                end
            end

            -- Start quest.
            quest:begin(player)
        end
    end
end

local function abelardCorrectTrade(player, csid, option)
    -- Handle gil reward.
    player:confirmTrade()
    npcUtil.giveCurrency(player, 'gil', monumentTable[quest:getVar(player, '[EF]TabletZoneId')][2])

    -- Complete quest.
    if csid == 47 then
        player:setCharVar('[EF]MonumentBitmask', 0)
        player:setCharVar('[EF]MonumentCount', 0)
        npcUtil.giveKeyItem(player, xi.ki.MAP_OF_THE_CRAWLERS_NEST)
        quest:complete(player)

    -- Continue quest.
    elseif option == 100 then
        abelardAccept(player, option)

    -- Abort quest. Delete from log BUT remember tablets already given.
    elseif option == 110 then
        player:delQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.AN_EXPLORERS_FOOTSTEPS)
    end
end

local handleStoneMonument =
{
    ['Stone_Monument'] =
    {
        onTrade = function(player, npc, trade)
            if npcUtil.tradeHasExactly(trade, xi.item.LUMP_OF_SELBINA_CLAY) then
                player:confirmTrade()
                npcUtil.giveItem(player, xi.item.CLAY_TABLET)
                quest:setVar(player, '[EF]TabletZoneId', player:getZoneID())
            end
        end,
    },
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.SELBINA_RABAO) >= 1
        end,

        [xi.zone.SELBINA] =
        {
            ['Abelard'] =
            {
                onTrigger = function(player, npc)
                    local monumentBitmask = player:getCharVar('[EF]MonumentBitmask')

                    if monumentBitmask == 0 then
                        return quest:progressEvent(40) -- First time.
                    else
                        return quest:progressEvent(42) -- Declined further interaction after previously accepting and trading tablet.
                    end
                end,
            },

            onEventFinish =
            {
                [40] = function(player, csid, option, npc)
                    abelardAccept(player, option)
                end,

                [42] = function(player, csid, option, npc)
                    abelardAccept(player, option)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        -- Monuments
        [xi.zone.WEST_RONFAURE        ] = handleStoneMonument,
        [xi.zone.EAST_RONFAURE        ] = handleStoneMonument,
        [xi.zone.LA_THEINE_PLATEAU    ] = handleStoneMonument,
        [xi.zone.VALKURM_DUNES        ] = handleStoneMonument,
        [xi.zone.JUGNER_FOREST        ] = handleStoneMonument,
        [xi.zone.BATALLIA_DOWNS       ] = handleStoneMonument,
        [xi.zone.NORTH_GUSTABERG      ] = handleStoneMonument,
        [xi.zone.SOUTH_GUSTABERG      ] = handleStoneMonument,
        [xi.zone.KONSCHTAT_HIGHLANDS  ] = handleStoneMonument,
        [xi.zone.PASHHOW_MARSHLANDS   ] = handleStoneMonument,
        [xi.zone.ROLANBERRY_FIELDS    ] = handleStoneMonument,
        [xi.zone.WEST_SARUTABARUTA    ] = handleStoneMonument,
        [xi.zone.EAST_SARUTABARUTA    ] = handleStoneMonument,
        [xi.zone.TAHRONGI_CANYON      ] = handleStoneMonument,
        [xi.zone.BUBURIMU_PENINSULA   ] = handleStoneMonument,
        [xi.zone.MERIPHATAUD_MOUNTAINS] = handleStoneMonument,
        [xi.zone.SAUROMUGUE_CHAMPAIGN ] = handleStoneMonument,

        -- Quest giver
        [xi.zone.SELBINA] =
        {
            ['Abelard'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.CLAY_TABLET) then
                        local currentMonument   = monumentTable[quest:getVar(player, '[EF]TabletZoneId')][1]
                        local requestedMonument = quest:getVar(player, '[EF]TargetMonument')

                        -- We already traded that monument tablet.
                        if utils.mask.getBit(player:getCharVar('[EF]MonumentBitmask'), currentMonument) then
                            return quest:event(45)

                        -- We never traded that monument tablet.
                        else
                            player:incrementCharVar('[EF]MonumentBitmask', bit.lshift(1, currentMonument))
                            player:incrementCharVar('[EF]MonumentCount', 1)

                            if player:getCharVar('[EF]MonumentCount') == 17 then
                                return quest:progressEvent(47) -- Traded them all.
                            elseif currentMonument == requestedMonument then
                                return quest:progressEvent(41) -- Traded suggested one.
                            else
                                return quest:progressEvent(46) -- Traded different one.
                            end
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    -- You are supposed to have one of them. If not, you must have zoned before getting a new Clay.
                    if
                        not player:hasItem(xi.item.CLAY_TABLET) and
                        not player:hasItem(xi.item.LUMP_OF_SELBINA_CLAY) and
                        player:getLocalVar('[EF]ClayRecieved') ~= 1
                    then
                        return quest:event(44)

                    -- Monument clue (Events 43 and 49)
                    else
                        local eventParam = quest:getVar(player, '[EF]TargetMonument')
                        if eventParam >= 9 then
                            return quest:event(49, eventParam - 9)
                        else
                            return quest:event(43, eventParam)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                -- Requested monument.
                [41] = function(player, csid, option, npc)
                    abelardCorrectTrade(player, csid, option)
                end,

                -- Lost Clay and don't have tablet either.
                [44] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.LUMP_OF_SELBINA_CLAY) then
                        player:setLocalVar('[EF]ClayRecieved', 1)
                    end
                end,

                -- Had already traded this monument tablet.
                [45] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.LUMP_OF_SELBINA_CLAY) then
                        player:confirmTrade()
                        player:setLocalVar('[EF]ClayRecieved', 1)
                    end
                end,

                -- Different than requested monument tablet.
                [46] = function(player, csid, option, npc)
                    abelardCorrectTrade(player, csid, option)
                end,

                -- Complete quest.
                [47] = function(player, csid, option, npc)
                    abelardCorrectTrade(player, csid, option)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.SELBINA] =
        {
            ['Abelard'] = quest:event(48):replaceDefault(),
        },
    },
}

return quest
