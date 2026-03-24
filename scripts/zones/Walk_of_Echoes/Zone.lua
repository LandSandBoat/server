-----------------------------------
-- Zone: Walk_of_Echoes
-----------------------------------
require('scripts/globals/npc_util')
---@type TZone
local zoneObject = {}

-- Forward declarations for EXP/Merit Guide menus
local guideMenu  = {}
local page1 = {}
local page2 = {}
local page3 = {}
local page4 = {}
local page5 = {}
local page6 = {}
local page7 = {}
local page8 = {}
local page9 = {}
local page10 = {}
local page11 = {}

local delaySendMenu = function(player)
    player:timer(50, function(playerArg)
        playerArg:customMenu(guideMenu)
    end)
end

guideMenu =
{
    title = 'Destination?',
    options = {},
}

page1 =
{
    {
        'EXIT',
        function(player)
        end
    },
    {
        'East Ronfaure (1-14)',
        function(playerArg)
            playerArg:setPos(86.4610, -59.6994, 241.4913, 29, xi.zone.EAST_RONFAURE)
        end,
    },
    {
        'South Gustaberg (1-14)',
        function(playerArg)
            playerArg:setPos(548.8903, -0.7633, -316.1219, 60, xi.zone.SOUTH_GUSTABERG)
        end,
    },
    {
        'West Sarutabaruta  (1-14)',
        function(playerArg)
            playerArg:setPos(150.0148, -0.3757, -316.7338, 135, xi.zone.WEST_SARUTABARUTA)
        end,
    },
    {
        'Next',
        function(playerArg)
            guideMenu.options = page2
            delaySendMenu(playerArg)
        end,
    },
}

page2 =
{
    {
        'Valkurm Dunes (14-21)',
        function(playerArg)
            playerArg:setPos(135.2247, -7.4763, 96.4053, 33, xi.zone.VALKURM_DUNES)
        end,
    },
    {
        'Qufim Island (21-35)',
        function(playerArg)
            playerArg:setPos(-258.3347, -20.0000, 300.8070, 238, xi.zone.QUFIM_ISLAND)
        end,
    },
    {
        'Crawlers Nest (35-55)',
        function(playerArg)
            playerArg:setPos(354.3741, -32.2071, -22.5341, 175, xi.zone.CRAWLERS_NEST)
        end,
    },
    {
        'Previous',
        function(playerArg)
            guideMenu.options = page1
            delaySendMenu(playerArg)
        end,
    },
    {
        'Next',
        function(playerArg)
            guideMenu.options = page3
            delaySendMenu(playerArg)
        end,
    },
}

page3 =
{
    {
        'Cape Teriggan (55-66)',
        function(playerArg)
            playerArg:setPos(-187.5810, 8.0470, -73.6966, 210, xi.zone.CAPE_TERIGGAN)
        end,
    },
    {
        'Wajaom Woodlands (55-65)',
        function(playerArg)
            playerArg:setPos(-200.1854, -10.0000, 91.8009, 53, xi.zone.WAJAOM_WOODLANDS)
        end,
    },
    {
        'The Boyahda Tree (55-69)',
        function(playerArg)
            playerArg:setPos(339.7918, 8.6358, -69.4237, 181, xi.zone.THE_BOYAHDA_TREE)
        end,
    },
    {
        'Previous',
        function(playerArg)
            guideMenu.options = page2
            delaySendMenu(playerArg)
        end,
    },
    {
        'Next',
        function(playerArg)
            guideMenu.options = page4
            delaySendMenu(playerArg)
        end,
    },
}

page4 =
{
    {
        'RuAun Gardens (68-76)',
        function(playerArg)
            playerArg:setPos(-0.6167, -44.0130, -165.7867, 185, xi.zone.RUAUN_GARDENS)
        end,
    },
    {
        'Misareaux Coast (68-80)',
        function(playerArg)
            playerArg:setPos(-44.6588, -32.3265, 274.5248, 230, xi.zone.MISAREAUX_COAST)
        end,
    },
    {
        'The Shrine of RuAvitau (70-82)',
        function(playerArg)
            playerArg:setPos(4.7311, -15.5148, -2.4892, 68, xi.zone.THE_SHRINE_OF_RUAVITAU)
        end,
    },
    {
        'Previous',
        function(playerArg)
            guideMenu.options = page3
            delaySendMenu(playerArg)
        end,
    },
    {
        'Next',
        function(playerArg)
            guideMenu.options = page9
            delaySendMenu(playerArg)
        end,
    },
}

page9 =
{
    {
        'The Shrine of RuAvitau (73-82)',
        function(playerArg)
            playerArg:setPos(740.4669, -99.6000, -655.9205, 230, xi.zone.THE_SHRINE_OF_RUAVITAU)
        end,
    },
    {
        'Dangruf Wadi (80-90)',
        function(playerArg)
            playerArg:setPos(-16.6683, -0.2101, -0.0809, 146, xi.zone.DANGRUF_WADI)
        end,
    },
    {
        'Mount Zhayolm (80-90)',
        function(playerArg)
            playerArg:setPos(-580.4277, -23.6067, -34.7014, 64, xi.zone.MOUNT_ZHAYOLM)
        end,
    },
    {
        'Previous',
        function(playerArg)
            guideMenu.options = page4
            delaySendMenu(playerArg)
        end,
    },
    {
        'Next',
        function(playerArg)
            guideMenu.options = page10
            delaySendMenu(playerArg)
        end,
    },
}

page10 =
{
    {
        'Crawlers Nest (82-96)',
        function(playerArg)
            playerArg:setPos(12.6418, -0.3837, -299.6174, 16, xi.zone.CRAWLERS_NEST)
        end,
    },
    {
        'Garlaige Citadel (85-95)',
        function(playerArg)
            playerArg:setPos(-378.7412, -5.9991, 361.1081, 62, xi.zone.GARLAIGE_CITADEL)
        end,
    },
    {
        'Gustav Tunnel (90-99)',
        function(playerArg)
            playerArg:setPos(-60.2877, -10.6451, -135.5146, 195, xi.zone.GUSTAV_TUNNEL)
        end,
    },
    {
        'Previous',
        function(playerArg)
            guideMenu.options = page9
            delaySendMenu(playerArg)
        end,
    },
    {
        'Next',
        function(playerArg)
            guideMenu.options = page11
            delaySendMenu(playerArg)
        end,
    },
}

page11 =
{
    {
        'Ceizak Battlegrounds (90-99)',
        function(playerArg)
            playerArg:setPos(329.6800, 0.3515, 126.9239, 72, xi.zone.CEIZAK_BATTLEGROUNDS)
        end,
    },
    {
        'Morimar Basalt Mines (93-99)',
        function(playerArg)
            playerArg:setPos(-128.0082, -33.4823, 294.7052, 67, xi.zone.MORIMAR_BASALT_FIELDS)
        end,
    },
    {
        'Previous',
        function(playerArg)
            guideMenu.options = page10
            delaySendMenu(playerArg)
        end,
    },
}

page5 =
{
    {
        'EXIT',
        function(player)
        end
    },
    {
        'King Ranperres Tomb',
        function(playerArg)
            playerArg:setPos(21.4849, 0.0000, -277.3308, 57, xi.zone.KING_RANPERRES_TOMB)
        end,
    },
    {
        'Bhaflau Thickets - Lower',
        function(playerArg)
            playerArg:setPos(-574.0469, -8.2500, 40.2076, 63, xi.zone.BHAFLAU_THICKETS)
        end,
    },
    {
        'Bhaflau Thickets - Upper',
        function(playerArg)
            playerArg:setPos(-493.5, -16, -76.4994, 129, xi.zone.BHAFLAU_THICKETS)
        end,
    },
    {
        'DHO Gate 1',
        function(playerArg)
            playerArg:setPos(-41.7247, 0.0000, -58.5082, 54, xi.zone.DHO_GATES)
        end,
    },
    {
        'Next',
        function(playerArg)
            guideMenu.options = page6
            delaySendMenu(playerArg)
        end,
    },
}

page6 =
{
    {
        'MOH Gate 1',
        function(playerArg)
            playerArg:setPos(391.1106, 30.0812, -10.6432, 74, xi.zone.MOH_GATES)
        end,
    },
    {
        'SIH Gate 1',
        function(playerArg)
            playerArg:setPos(-21.8246, 0.0151, -228.8976, 195, xi.zone.SIH_GATES)
        end,
    },
    {
        'SIH Gate 2',
        function(playerArg)
            playerArg:setPos(94.2589, 0.0572, -262.3954, 20, xi.zone.SIH_GATES)
        end,
    },
    {
        'Previous',
        function(playerArg)
            guideMenu.options = page5
            delaySendMenu(playerArg)
        end,
    },
    {
        'Next',
        function(playerArg)
            guideMenu.options = page7
            delaySendMenu(playerArg)
        end,
    },
}

page7 =
{
    {
        'SIH Gate 3',
        function(playerArg)
            playerArg:setPos(-1.1026, 0.0000, -259.4783, 6, xi.zone.SIH_GATES)
        end,
    },
    {
        'Reisenjima',
        function(playerArg)
            playerArg:setPos(-499.8680, -19.0587, -488.1039, 192, xi.zone.REISENJIMA)
        end,
    },
    {
        'Bibiki Bay 1',
        function(playerArg)
            playerArg:setPos(150.4, -28.2, 414.6331, 196, xi.zone.BIBIKI_BAY)
        end,
    },
    {
        'Bibiki Bay 2',
        function(playerArg)
            playerArg:setPos(196.56, -20, 274.2421, 66, xi.zone.BIBIKI_BAY)
        end,
    },
    {
        'Previous',
        function(playerArg)
            guideMenu.options = page6
            delaySendMenu(playerArg)
        end,
    },
    {
        'Next',
        function(playerArg)
            guideMenu.options = page8
            delaySendMenu(playerArg)
        end,
    },
}

page8 =
{
    {
        'Escha Zitah 1',
        function(playerArg)
            playerArg:setPos(-323.7006, 0.0000, 361.2220, 190, xi.zone.ESCHA_ZITAH)
        end,
    },
    {
        'Escha Zitah 2',
        function(playerArg)
            playerArg:setPos(526.1202, 2.4993, -179.8479, 6, xi.zone.ESCHA_ZITAH)
        end,
    },
    {
        'Gustav Tunnel',
        function(playerArg)
            playerArg:setPos(-26, -9.6, 131.5421, 241, xi.zone.GUSTAV_TUNNEL)
        end,
    },
    {
        'RaKaznar Inner Court',
        function(playerArg)
            playerArg:setPos(-326, -430.25, 300, 0, xi.zone.RAKAZNAR_INNER_COURT)
        end,
    },
    {
        'Previous',
        function(playerArg)
            guideMenu.options = page7
            delaySendMenu(playerArg)
        end,
    },
}


zoneObject.onInitialize = function(zone)
    -- First Walk entrance NPC — uses the Battlefield engine (event 32000).
    -- echoes_challenge.lua registers this name as the entryNpc for battlefieldId FIRST_WALK.
    zone:insertDynamicEntity({
        objtype  = xi.objType.NPC,
        name     = 'Dungeon Master',
        look     = 126,
        x        = -406.906,
        y        = 14.000,
        z        = -60.399,
        rotation = 194,
        widescan = 1,
        onTrade = function(player, npc, trade)
            return Battlefield.onEntryTrade(player, npc, trade)
        end,
        onTrigger = function(player, npc)
            return Battlefield.onEntryTrigger(player, npc)
        end,
    })

    -- First Walk exit NPC — inside the arena at (238, -8, -248).
    -- Players trigger this to leave the battlefield before it ends.
    zone:insertDynamicEntity({
        objtype  = xi.objType.NPC,
        name     = 'Walk_Exit',
        look     = 126,
        x        = 238,
        y        = -8,
        z        = -248,
        rotation = 128,
        widescan = 0,
        onTrigger = function(player, npc)
            if player:getBattlefield() then
                return Battlefield.onExitTrigger(player, npc)
            end
        end,
    })

    -- EXP Guide NPC (menu-based, pages 1-4, 9-11) - Maat appearance
    zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = 'EXP Guide',
        look = 126,
        x = -398,
        y = 14.0000,
        z = -60.0761,
        rotation = 185,
        widescan = 1,
        onTrade = function(player, npc, trade)
        end,
        onTrigger = function(player, npc)
            guideMenu.options = page1
            delaySendMenu(player)
        end,
    })

    -- Merit Guide NPC (menu-based, pages 5-8) - Atori-Tutori appearance
    zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = 'Merit Guide',
        look = '0x0100020500101120003000400050006000700000',
        x = -401.3526,
        y = 14.0000,
        z = -60.6267,
        rotation = 195,
        widescan = 1,
        onTrade = function(player, npc, trade)
        end,
        onTrigger = function(player, npc)
            guideMenu.options = page5
            delaySendMenu(player)
        end,
    })

    -- Custom NPC: Sexy dealer (Shiftrix model)
    -- Trades 12 Rabbit Hides for 5 augmented items
    zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = 'Sexy dealer',
        look = '0x0000E20300000000000000000000000000000000',
        x = -404.2824,
        y = 14.0000,
        z = -60.0869,
        rotation = 188,
        widescan = 1,

        onTrade = function(player, npc, trade)
            -- 12 Rabbit Hides (item 856)
            if npcUtil.tradeHasExactly(trade, {{856, 12}}) then
                -- Check inventory space (need 5 free slots)
                if player:getFreeSlotsCount() >= 5 then
                    -- Give items with augments: 132/1, 142/1, 129/1, 130/1
                    player:addItem(12569, 1, 132, 1, 142, 1, 129, 1, 130, 1)
                    player:addItem(12825, 1, 132, 1, 142, 1, 129, 1, 130, 1)
                    player:addItem(12441, 1, 132, 1, 142, 1, 129, 1, 130, 1)
                    player:addItem(12697, 1, 132, 1, 142, 1, 129, 1, 130, 1)
                    player:addItem(12953, 1, 132, 1, 142, 1, 129, 1, 130, 1)
                    player:confirmTrade()
                    player:printToPlayer('Shiftrix thanks you! Here are your items, hehehe.', 0, 'Sexy dealer')
                else
                    player:printToPlayer('You do not have enough inventory space!', 0, 'Sexy dealer')
                end
            else
                player:printToPlayer('Shiftrix needs 12 Rabbit Hides! Bring them to Shiftrix!', 0, 'Sexy dealer')
            end
        end,

        onTrigger = function(player, npc)
            player:customMenu({
                title = 'Sexy dealer',
                options = {
                    {
                        'Armor 20-40',
                        function(playerArg)
                            playerArg:printToPlayer('Please trade 12 Rabbit Hides to receive your Armor Set!', 0, 'Sexy dealer')
                        end,
                    },
                    {
                        'Exit',
                        function(playerArg)
                        end,
                    },
                },
            })
        end,
    })
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-420, 14, -49, 192)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
