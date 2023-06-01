-----------------------------------
-- Area: Norg
--  NPC: Nolan
-- Escha Beads Exchange NPC
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/weaponskillids")
local ID = require("scripts/zones/Norg/IDs")
-----------------------------------
local entity = {}

local wsTable =
{
-- [index] = { "varName", ws unlock ID, defined in database },
    [2]  = { "hasShijinSpiralUnlock", 60 },
    [3]  = { "hasExenteratorUnlock",  53 },
    [4]  = { "hasRequiescatUnlock",   56 },
    [5]  = { "hasResolutionUnlock",   57 },
    [6]  = { "hasRuinatorUnlock",     58 },
    [7]  = { "hasUpheavalUnlock",     63 },
    [8]  = { "hasEntropyUnlock",      52 },
    [9]  = { "hasStardiverUnlock",    61 },
    [10] = { "hasBladeShunUnlock",    51 },
    [11] = { "hasTachiShohaUnlock",   62 },
    [12] = { "hasRealmrazerUnlock",   55 },
    [13] = { "hasShattersoulUnlock",  59 },
    [14] = { "hasApexArrowUnlock",    50 },
    [15] = { "hasLastStandUnlock",    54 },
}

local function reLearnWeaponSkill(player)
    for i = 2, 15 do
        if
            player:getCharVar(wsTable[i][1]) == 1 and
            not player:hasLearnedWeaponskill(wsTable[i][2])
        then
            player:setCharVar(wsTable[i][1], 0)
            player:addLearnedWeaponskill(wsTable[i][2])
        end
    end
end

local function unlockWs(player, npc, ws)
    local paidWs       = player:getCharVar("PaidForMeritWs")
    local beadsBalance = player:getCurrency("escha_beads")
    local wsCost       = 50000

    local menu =
    {
        title = string.format("Spend %i points? (%i available)", wsCost, beadsBalance),

        options =
        {
            {
                "Yes, I'm sure!",
                function(playerArg)
                    player:timer(100, function(playerArgMenu)
                        if beadsBalance >= wsCost and ws == paidWs then
                            playerArgMenu:setCurrency("escha_beads", beadsBalance - wsCost)
                            playerArgMenu:setCharVar("PaidForMeritWs", 0)
                            playerArgMenu:setCharVar("Afterglow", 1)
                            -- playerArgMenu:setCharVar(wsTable[ws][1], 1) -- TODO: Remove charvar usage. Future some1-else problem, get fucked.
                            player:addLearnedWeaponskill(wsTable[ws][2])
                            playerArgMenu:PrintToPlayer("\129\153\129\154 Congratulations! You've unlocked a new Weaponskill! \129\154\129\153\n", 0, npc:getPacketName())
                        else
                            if ws > 15 or ws < 2 then
                                player:PrintToPlayer("DEBUG: Incorrect value for variable `ws`. Please contact an administrator.", 0, npc:getPacketName()) -- This message should NEVER trigger.
                            elseif beadsBalance < wsCost then
                                player:PrintToPlayer("You do not possess enough beads to complete this transaction.", 0, npc:getPacketName())
                            else
                                player:PrintToPlayer("You do not meet the requirements to unlock this weaponskill.", 0, npc:getPacketName())
                            end
                        end
                    end)
                end,
            },
            {
                "No, I change my mind.",
                function(playerArg)
                    return
                end,
            },
        },
    }

    player:timer(150, function(playerArg)
        player:customMenu(menu)
    end)
end

local function completeTransaction(player, npc, item, cost)
    local beadsBalance = player:getCurrency("escha_beads")
    local confirmMenu =
    {
        title = string.format("Spend %i points? (%i available)", cost, beadsBalance),

        options =
        {
            {
                "Yes, I'm sure!",
                function(playerArg)
                    print(item)
                    if beadsBalance >= cost and item ~= nil then
                        if npcUtil.giveItem(player, item) then
                            player:setCurrency("escha_beads", beadsBalance - cost)
                        else
                            player:PrintToPlayer("You do not meet the requirements to obtain this item.", 0, npc:getPacketName())
                        end
                    end
                end,
            },
            {
                "No, I change my mind.",
                function(playerArg)
                    return
                end,
            },
        },
    }

    player:customMenu(confirmMenu)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- First thing: Let's convert Weaponskills to the proper unlock system.
    reLearnWeaponSkill(player)

    -- Now do whatever you wanna do.
    local beadsBalance = player:getCurrency("escha_beads")
    local item         = 0
    local cost         = 0

    -- Forward declarations (required)
    local menu  = {}
    local page1 = {}
    local page2 = {}
    local page3 = {}
    local page4 = {}
    local page5 = {}
    local page6 = {}
    local page7 = {}
    local page8 = {}
    local page9 = {}

    local delaySendMenu = function(playerArg)
        player:timer(100, function(playerArgMenu)
            playerArgMenu:customMenu(menu)
        end)
    end

    -- Print Beads balance
    player:PrintToPlayer(string.format("You have %s escha beads available to spend. Choose wisely.", beadsBalance), 0, npc:getPacketName())

    menu =
    {
        title = "Choose a reward",
        options = {},
    }

    page1 =
    {
        {
            "Pearlscale (grants Elvorseal)",
            function(playerArg)
                playerArg:timer(50, function(playerArgMenu)
                    item = 5714
                    cost = 250
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Siren's hair",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 1313
                    cost = 5000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Scintillant ingot",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 2275
                    cost = 5000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Next Page",
            function(playerArg)
                menu.options = page2
                delaySendMenu(playerArg)
            end,
        },
    }

    page2 =
    {
        {
            "Teleport ring: Holla",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 14661
                    cost = 5000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Teleport ring: Mea",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 14662
                    cost = 5000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Teleport ring: Dem",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 14663
                    cost = 5000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Next Page",
            function(playerArg)
                menu.options = page3
                delaySendMenu(playerArg)
            end,
        },
    }

    page3 =
    {
        {
            "Emico mantle",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 27597
                    cost = 10000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Crested torque",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 28349
                    cost = 10000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Setae ring",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 28529
                    cost = 10000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Megasco earring",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 28488
                    cost = 10000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Salire belt",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 28425
                    cost = 10000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Charitoni sling",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 21347
                    cost = 10000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Next Page",
            function(playerArg)
                menu.options = page4
                delaySendMenu(playerArg)
            end,
        },
    }

    page4 =
    {
        {
            "Dew silk cape",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 27598
                    cost = 10000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Adsilio boots",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 28271
                    cost = 10000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Fylgja torque",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 11579
                    cost = 15000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Dew silk cape +1",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 27599
                    cost = 15000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Adsilio boots +1",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 28272
                    cost = 15000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Next Page",
            function(playerArg)
                menu.options = page5
                delaySendMenu(playerArg)
            end,
        },
    }

    page5 =
    {
        {
            "Carver's torque",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 10948
                    cost = 15000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Tanner's torque",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 10952
                    cost = 15000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Smithy's torque",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 10949
                    cost = 15000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Goldsmith's torque",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 10950
                    cost = 15000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Boneworker's torque",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 10953
                    cost = 15000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Weaver's torque",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 10951
                    cost = 15000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Next Page",
            function(playerArg)
                menu.options = page6
                delaySendMenu(playerArg)
            end,
        },
    }

    page6 =
    {
        {
            "Alchemist's torque",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 10954
                    cost = 15000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Culinarian torque",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 10955
                    cost = 15000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Fylgja torque +1",
            function(playerArg)
                player:timer(50, function(playerArgMenu)
                    item = 11580
                    cost = 25000
                    completeTransaction(player, npc, item, cost)
                end)
            end,
        },
        {
            "Next Page",
            function(playerArg)
                menu.options = page7
                delaySendMenu(playerArg)
            end,
        },
    }

    page7 =
    {
        {
            "Apex Arrow (Bow)",
            function(playerArg)
                unlockWs(player, npc, 14)
            end,
        },
        {
            "Blade: Shun (Katana)",
            function(playerArg)
                unlockWs(player, npc, 10)
            end,
        },
        {
            "Entropy (Scythe)",
            function(playerArg)
                unlockWs(player, npc, 8)
            end,
        },
        {
            "Exenterator (Dagger)",
            function(playerArg)
                unlockWs(player, npc, 3)
            end,
        },
        {
            "Last Stand (Gun)",
            function(playerArg)
                unlockWs(player, npc, 15)
            end,
        },
        {
            "Realmrazer (Club)",
            function(playerArg)
                unlockWs(player, npc, 12)
            end,
        },
        {
            "Next Page",
            function(playerArg)
                menu.options = page8
                delaySendMenu(playerArg)
            end,
        },
    }

    page8 =
    {
        {
            "Requiescat (Sword)",
            function(playerArg)
                unlockWs(player, npc, 4)
            end,
        },
        {
            "Resolution (Great Sword)",
            function(playerArg)
                unlockWs(player, npc, 5)
            end,
        },
        {
            "Ruinator (Axe)",
            function(playerArg)
                unlockWs(player, npc, 6)
            end,
        },
        {
            "Shattersoul (Staff)",
            function(playerArg)
                unlockWs(player, npc, 13)
            end,
        },
        {
            "Shijin Spiral (H2H)",
            function(playerArg)
                unlockWs(player, npc, 2)
            end,
        },
        {
            "Stardiver (Pole)",
            function(playerArg)
                unlockWs(player, npc, 9)
            end,
        },
        {
            "Next Page",
            function(playerArg)
                menu.options = page9
                delaySendMenu(playerArg)
            end,
        },
    }

    page9 =
    {
        {
            "Tachi: Shoha (Great Katana)",
            function(playerArg)
                unlockWs(player, npc, 11)
            end,
        },
        {
            "Upheaval (Great Axe)",
            function(playerArg)
                unlockWs(player, npc, 7)
            end,
        },
        {
            "Exit",
            function(playerArg)
                return
            end,
        },
    }

    menu.options = page1
    delaySendMenu(player)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
