-----------------------------------
-- Area: Abyssea - Konschtat
--  NPC: Cruor Prospector
-- Type: Cruor NPC
-- !pos 132.000 -75.856 -822.000 15
-----------------------------------
local ID = require("scripts/zones/Abyssea-Konschtat/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/abyssea")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local cruor = player:getCurrency("cruor")
    local demilune = tpz.abyssea.getDemiluneAbyssite(player)
    player:startEvent(2002, cruor, demilune)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local Price = 0
    local ItemID = 0
    local Quantity = 1

    -- Items Page 1
    if option == 65537 then -- Perle Salade
        Price = 4000
        ItemID = 11503
    elseif option == 131073 then -- Perle Hauberk
        Price = 5000
        ItemID = 13759
    elseif option == 196609 then -- Perle Moufles
        Price = 3000
        ItemID = 12745
    elseif option == 262145 then -- Perle Brayettes
        Price = 3000
        ItemID = 14210
    elseif option == 327681 then -- Perle Solerets
        Price = 3000
        ItemID = 11413
    elseif option == 393217 then -- Aurore Beret
        Price = 4000
        ItemID = 11504
    elseif option == 458753 then -- Aurore Doublet
        Price = 5000
        ItemID = 13760
    elseif option == 524289 then -- Aurore Gloves
        Price = 3000
        ItemID = 12746
    elseif option == 589825 then -- Aurore Brais
        Price = 3000
        ItemID = 14257
    elseif option == 655361 then -- Aurore Gaiters
        Price = 3000
        ItemID = 11414

    -- Items Page 2
    elseif option == 720897 then -- Teal Chapeau
        Price = 4000
        ItemID = 11505
    elseif option == 786433 then -- Teal Saio
        Price = 5000
        ItemID = 13778
    elseif option == 851969 then -- Teal Cuffs
        Price = 3000
        ItemID = 12747
    elseif option == 917505 then -- Teal Slops
        Price = 3000
        ItemID = 14258
    elseif option == 983041 then -- Teal Pigaches
        Price = 3000
        ItemID = 11415
    elseif option == 17825793 then -- 1x Forbidden Key
        Price = 500
        ItemID = 2490
    elseif option == 84934657 then -- 5x Forbidden Key
        Price = 2500
        ItemID = 2490
        Quantity = 5
    elseif option == 168820737 then -- 10x Forbidden Key
        Price = 5000
        ItemID = 2490
        Quantity = 10
    elseif option == 504365057 then -- 30x Forbidden Key
        Price = 15000
        ItemID = 2490
        Quantity = 30
    elseif option == 839909377 then -- 50x Forbidden Key
        Price = 25000
        ItemID = 2490
        Quantity = 50

    -- Temp items
    elseif option == 65538 then -- Lucid Potion I
        if player:addTempItem(5824, 1) then
            player:messageSpecial(ID.text.ITEM_OBTAINED, 5824)
            player:delCurrency("cruor", 80)
        end
    elseif option == 131074 then -- Lucid Ether I
        if player:addTempItem(5827, 1) then
            player:messageSpecial(ID.text.ITEM_OBTAINED, 5827)
            player:delCurrency("cruor", 80)
        end
    elseif option == 196610 then -- Catholicon
        if player:addTempItem(4206, 1) then
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4206)
            player:delCurrency("cruor", 80)
        end
    elseif option == 262146 then -- Dusty Elixer
        if player:addTempItem(5433, 1) then
            player:messageSpecial(ID.text.ITEM_OBTAINED, 5433)
            player:delCurrency("cruor", 120)
        end
    elseif option == 327682 then -- Clear Salve I
        if player:addTempItem(5837, 1) then
            player:messageSpecial(ID.text.ITEM_OBTAINED, 5837)
            player:delCurrency("cruor", 120)
        end
    elseif option == 393218 then -- Stalworts Tonic
        if player:addTempItem(5839, 1) then
            player:messageSpecial(ID.text.ITEM_OBTAINED, 5839)
            player:delCurrency("cruor", 150)
        end
    elseif option == 458754 then -- Ascetics Tonic
        if player:addTempItem(5841, 1) then
            player:messageSpecial(ID.text.ITEM_OBTAINED, 5841)
            player:delCurrency("cruor", 150)
        end
    elseif option == 524290 then -- Champion's Tonic
        if player:addTempItem(5843, 1) then
            player:messageSpecial(ID.text.ITEM_OBTAINED, 5843)
            player:delCurrency("cruor", 150)
        end
    elseif option == 589826 then -- Lucid Potion II
        if player:addTempItem(5825, 1) then
            player:messageSpecial(ID.text.ITEM_OBTAINED, 5825)
            player:delCurrency("cruor", 200)
        end
    elseif option == 655362 then -- Lucid Potion II
        if player:addTempItem(5828, 1) then
            player:messageSpecial(ID.text.ITEM_OBTAINED, 5828)
            player:delCurrency("cruor", 200)
        end

    -- Keyitems
    elseif option == 65539 then -- Map of Abyssea - Konschtat
        if not player:hasKeyItem(tpz.ki.MAP_OF_ABYSSEA_KONSCHTAT) then
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MAP_OF_ABYSSEA_KONSCHTAT)
            player:addKeyItem(tpz.ki.MAP_OF_ABYSSEA_KONSCHTAT)
            player:delCurrency("cruor", 3500)
        end
    elseif option == 131075 then -- Ivory Abyssite of Sojourn
        if not player:hasKeyItem(tpz.ki.IVORY_ABYSSITE_OF_SOJOURN) then
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.IVORY_ABYSSITE_OF_SOJOURN)
            player:addKeyItem(tpz.ki.IVORY_ABYSSITE_OF_SOJOURN)
            player:delCurrency("cruor", 6000)
        end
    elseif option == 196611 then -- Ivory Abyssite of Confluence
        if not player:hasKeyItem(tpz.ki.IVORY_ABYSSITE_OF_CONFLUENCE) then
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.IVORY_ABYSSITE_OF_CONFLUENCE)
            player:addKeyItem(tpz.ki.IVORY_ABYSSITE_OF_CONFLUENCE)
            player:delCurrency("cruor", 4800)
        end
    elseif option == 262147 then -- Ivory Abyssite of Expertise
        if not player:hasKeyItem(tpz.ki.IVORY_ABYSSITE_OF_EXPERTISE) then
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.IVORY_ABYSSITE_OF_EXPERTISE)
            player:addKeyItem(tpz.ki.IVORY_ABYSSITE_OF_EXPERTISE)
            player:delCurrency("cruor", 4800)
        end
    elseif option == 458755 then -- Clear Demilune Abyssite
        if not player:hasKeyItem(tpz.ki.CLEAR_DEMILUNE_ABYSSITE) then
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CLEAR_DEMILUNE_ABYSSITE)
            player:addKeyItem(tpz.ki.CLEAR_DEMILUNE_ABYSSITE)
            player:delCurrency("cruor", 300)
        end

    -- Enhancement Effects (only removed by zoning, infinite duration)
    elseif option == 393220 then -- HP Boost
        player:addStatusEffectEx(tpz.effect.ABYSSEA_HP, tpz.effect.MAX_HP_BOOST, 20+(tpz.abyssea.getAbyssiteTotal(player, "MERIT") *10), 0, 0)
        player:addHP(20+(tpz.abyssea.getAbyssiteTotal(player, "MERIT") *10) *10)
        player:delCurrency("cruor", 50)
    elseif option == 458756 then -- MP Boost
        player:addStatusEffectEx(tpz.effect.ABYSSEA_MP, tpz.effect.MAX_MP_BOOST, 10+(tpz.abyssea.getAbyssiteTotal(player, "MERIT") *5), 0, 0)
        player:addMP(10+(tpz.abyssea.getAbyssiteTotal(player, "MERIT") *5) *10)
        player:delCurrency("cruor", 120)
    elseif option == 524292 then -- STR-DEX Boost
        player:addStatusEffectEx(tpz.effect.ABYSSEA_STR, tpz.effect.STR_BOOST, 10+(tpz.abyssea.getAbyssiteTotal(player, "FURTHERANCE") *10), 0, 0)
        player:addStatusEffectEx(tpz.effect.ABYSSEA_DEX, tpz.effect.DEX_BOOST, 10+(tpz.abyssea.getAbyssiteTotal(player, "FURTHERANCE") *10), 0, 0)
        player:delCurrency("cruor", 120)
    elseif option == 589828 then -- VIT-AGI Boost
        player:addStatusEffectEx(tpz.effect.ABYSSEA_VIT, tpz.effect.VIT_BOOST, 10+(tpz.abyssea.getAbyssiteTotal(player, "FURTHERANCE") *10), 0, 0)
        player:addStatusEffectEx(tpz.effect.ABYSSEA_AGI, tpz.effect.AGI_BOOST, 10+(tpz.abyssea.getAbyssiteTotal(player, "FURTHERANCE") *10), 0, 0)
        player:delCurrency("cruor", 100)
    elseif option == 655364 then -- INT-MND-CHR Boost
        player:addStatusEffectEx(tpz.effect.ABYSSEA_INT, tpz.effect.INT_BOOST, 10+(tpz.abyssea.getAbyssiteTotal(player, "FURTHERANCE") *10), 0, 0)
        player:addStatusEffectEx(tpz.effect.ABYSSEA_MND, tpz.effect.MND_BOOST, 10+(tpz.abyssea.getAbyssiteTotal(player, "FURTHERANCE") *10), 0, 0)
        player:addStatusEffectEx(tpz.effect.ABYSSEA_CHR, tpz.effect.CHR_BOOST, 10+(tpz.abyssea.getAbyssiteTotal(player, "FURTHERANCE") *10), 0, 0)
        player:delCurrency("cruor", 100)
    elseif option == 720900 then -- All Enhancements
        player:addStatusEffectEx(tpz.effect.ABYSSEA_HP, tpz.effect.MAX_HP_BOOST, 20+(tpz.abyssea.getAbyssiteTotal(player, "MERIT") *10), 0, 0)
        player:addHP(20+(tpz.abyssea.getAbyssiteTotal(player, "MERIT") *10) *10)
        player:addStatusEffectEx(tpz.effect.ABYSSEA_MP, tpz.effect.MAX_MP_BOOST, 10+(tpz.abyssea.getAbyssiteTotal(player, "MERIT") *5), 0, 0)
        player:addMP(10+(tpz.abyssea.getAbyssiteTotal(player, "MERIT") *5) *10)
        player:addStatusEffectEx(tpz.effect.ABYSSEA_STR, tpz.effect.STR_BOOST, 10+(tpz.abyssea.getAbyssiteTotal(player, "FURTHERANCE") *10), 0, 0)
        player:addStatusEffectEx(tpz.effect.ABYSSEA_DEX, tpz.effect.DEX_BOOST, 10+(tpz.abyssea.getAbyssiteTotal(player, "FURTHERANCE") *10), 0, 0)
        player:addStatusEffectEx(tpz.effect.ABYSSEA_VIT, tpz.effect.VIT_BOOST, 10+(tpz.abyssea.getAbyssiteTotal(player, "FURTHERANCE") *10), 0, 0)
        player:addStatusEffectEx(tpz.effect.ABYSSEA_AGI, tpz.effect.AGI_BOOST, 10+(tpz.abyssea.getAbyssiteTotal(player, "FURTHERANCE") *10), 0, 0)
        player:addStatusEffectEx(tpz.effect.ABYSSEA_INT, tpz.effect.INT_BOOST, 10+(tpz.abyssea.getAbyssiteTotal(player, "FURTHERANCE") *10), 0, 0)
        player:addStatusEffectEx(tpz.effect.ABYSSEA_MND, tpz.effect.MND_BOOST, 10+(tpz.abyssea.getAbyssiteTotal(player, "FURTHERANCE") *10), 0, 0)
        player:addStatusEffectEx(tpz.effect.ABYSSEA_CHR, tpz.effect.CHR_BOOST, 10+(tpz.abyssea.getAbyssiteTotal(player, "FURTHERANCE") *10), 0, 0)
        player:delCurrency("cruor", 470)
    end

    if ItemID ~= 0 then
        if player:getFreeSlotsCount() >= 1 then
            player:messageSpecial(ID.text.ITEM_OBTAINED, ItemID)
            player:addItem(ItemID, Quantity)
            player:delCurrency("cruor", Price)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, ItemID)
        end
    end
end
