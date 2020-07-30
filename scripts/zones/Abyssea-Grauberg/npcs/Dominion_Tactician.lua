-----------------------------------
-- Area: Abyssea - Grauberg
--  NPC: Dominion Tactician
-----------------------------------
local ID = require("scripts/zones/Abyssea-Grauberg/IDs")
require("scripts/globals/abyssea")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local DM = player:getDominionNotes()
    local Trophies = 0 -- Max all Trophy = 4294967295 sort out its bit mask later.
    player:startEvent(120, DM, 0, 0, 0, 0, Trophies)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local Price = 0
    local TempItem = false
    local ItemID = 0
    local aug1 = 0
    local aug2 = 0
    local aug3 = 0
    local aug4 = 0
    local a1 = 0
    local a2 = 0
    local a3 = 0
    local a4 = 0
    local v1 = 0
    local v2 = 0
    local v3 = 0
    local v4 = 0

    -- Spending Dominion Notes
    if option == 257 then -- Unkai Domaru
        Price = 1500
        ItemID = 12039
    elseif option == 258 then -- Petrify Screen
        Price = 300
        TempItem = true
        ItemID = 5876
    elseif option == 259 then -- Augmented Yataghan
        Price = 2500
        ItemID = 16485
        -- Work out augment selection via math.random
        -- (see Lower Jeuno Tenshodo Coffer script)
    elseif option == 513 then -- Inga Ningi
        Price = 1500
        ItemID = 12040
    elseif option == 514 then -- Terror Screen
        Price = 300
        TempItem = true
        ItemID = 5877
    elseif option == 515 then -- Augmented Doom Tabar
        Price = 2500
        ItemID = 16660
        -- Augment here
    elseif option == 769 then -- Lancer's Plackart
        Price = 1500
        ItemID = 12041
    elseif option == 770 then -- Amnesia Screen
        Price = 300
        TempItem = true
        ItemID = 5878
    elseif option == 771 then -- Augmented Yukitsugu
        Price = 2500
        ItemID = 16971
        -- Augment here
    elseif option == 1025 then -- Caller's Doublet
        Price = 1500
        ItemID = 12042
    elseif option == 1026 then -- Doom Screen
        Price = 300
        TempItem = true
        ItemID = 5879
    elseif option == 1281 then -- Mavi Mintan
        Price = 1500
        ItemID = 12043
    elseif option == 1282 then -- Poison Screen
        Price = 300
        TempItem = true
        ItemID = 5880
    elseif option == 1537 then -- Navarch's Frac
        Price = 1500
        ItemID = 12044
    elseif option == 1793 then -- Cirque Farsetto
        Price = 1500
        ItemID = 12045
    elseif option == 2049 then -- Charis Casaque
        Price = 1500
        ItemID = 12046
    elseif option == 2305 then -- Savant's Gown
        Price = 1500
        ItemID = 12047
    elseif option == 2561 then -- Incredescent Shade
        Price = 300
        ItemID = 3295
    elseif option == 2817 then -- Decredescent Shade
        Price = 300
        ItemID = 3296
    end

    if option > 256 and option < 2818 then
        if player:getDominionNotes() > Price then
            if TempItem then
                if player:addTempItem(ItemID, 1) then
                    player:delCurrency("dominion_note", Price)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, ItemID)
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, ItemID)
                end
            else
                if player:addItem(ItemID, 1, a1, v1, a2, v2, a3, v3, a4, v4) then
                    player:delCurrency("dominion_note", Price)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, ItemID)
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, ItemID)
                end
            end
        end
    end

    -- Trophy trades for gear
    -- if option == 65796 then
    --     .
    -- elseif option ==
    --     .
    -- end
end
