-----------------------------------
-- Area: Nashmau
--  NPC: Kilusha
-- Einherjar-related NPC, Smoldering Glass, Therion Ichor items
-- !pos 0.373 -6.667 14.712 53
-----------------------------------
local ID = zones[xi.zone.NASHMAU]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local lampCost = 60000 -- base cost without RHAPSODY_IN_AZURE key item

    if player:hasKeyItem(xi.ki.RHAPSODY_IN_AZURE) then
        lampCost = 1000
    end

    if
        npcUtil.tradeHasExactly(trade, { { 'gil', lampCost } }) and
        player:getCharVar('EinherjarIntro') ~= 1
    then
        if npcUtil.giveItem(player, xi.item.SMOLDERING_LAMP) then
            player:tradeComplete()
            player:startEvent(25)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.SMOLDERING_LAMP)
        end
    end
end

entity.onTrigger = function(player, npc)
    local ichor = player:getCurrency('therion_ichor')
    local allowValkyrieBuying = 29360128 -- set this to 0 if you wish to allow players to buy feather key items without KI
    local lampCost = 60000 -- base cost without RHAPSODY_IN_AZURE key item
    local reentryTime = 20 -- in hours
    local toau = player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.IMMORTAL_SENTRIES)

    if player:hasKeyItem(xi.ki.RHAPSODY_IN_AZURE) then
        lampCost = 1000
        reentryTime = 1
    end

    if player:hasKeyItem(xi.ki.MARK_OF_THE_EINHERJAR) then -- June 2012 update added Valkyrie items
        allowValkyrieBuying = 0
    end

    if player:getMainLvl() <= 59 or not toau then
        player:startEvent(22) -- worthless CS
    elseif
        (player:getMainLvl() >= 60 or toau) and
        player:getCharVar('EinherjarIntro') == 1
    then
        player:startEvent(23, lampCost, 856, 3, 616, 10, 172, 172, 0) -- Einherjar introduction
    else
        player:startEvent(24, lampCost, 856, 3, reentryTime, 10, 135, allowValkyrieBuying, ichor)
        player:setLocalVar('reentryTime', reentryTime)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 24 and option == 6 then -- about Entry Conditions
        player:updateEvent(53, 10, 3, player:getLocalVar('reentryTime'), 10, 231, xi.item.SMOLDERING_LAMP, xi.item.GLOWING_LAMP)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 23 then
        player:setCharVar('EinherjarIntro', 0) -- deletes CharVar set at character creation
    elseif csid == 24 and option ~= 1073741824 and option ~= 0 then
        local kilushaItems =
        {
            [1] =  { item = xi.item.ANIMATOR_P1,          cost =  15000 },
            [2] =  { item = xi.item.ASLAN_CAPE,           cost =  15000 },
            [3] =  { item = xi.item.GLEEMANS_CAPE,        cost =  15000 },
            [4] =  { item = xi.item.RITTER_GORGET,        cost =  15000 },
            [5] =  { item = xi.item.KUBIRA_BEAD_NECKLACE, cost =  15000 },
            [6] =  { item = xi.item.MORGANAS_CHOKER,      cost =  15000 },
            [7] =  { item = xi.item.BUCANEERS_BELT,       cost =  15000 },
            [8] =  { item = xi.item.IOTA_RING,            cost =  15000 },
            [9] =  { item = xi.item.OMEGA_RING,           cost =  15000 },
            [10] = { item = xi.item.DELT_RING,            cost =  15000 },
            [11] = { item = xi.item.RUBBER_CAP,           cost =   5000 },
            [12] = { item = xi.item.RUBBER_HARNESS,       cost =   5000 },
            [13] = { item = xi.item.RUBBER_GLOVES,        cost =   5000 },
            [14] = { item = xi.item.RUBBER_CHAUSSES,      cost =   5000 },
            [15] = { item = xi.item.RUBBER_SOLES,         cost =   5000 },
            [16] = { item = xi.item.NETHEREYE_CHAIN,      cost =   5000 },
            [17] = { item = xi.item.NETHERFIELD_CHAIN,    cost =   5000 },
            [18] = { item = xi.item.NETHERSPIRIT_CHAIN,   cost =   5000 },
            [19] = { item = xi.item.NETHERCANT_CHAIN,     cost =   5000 },
            [20] = { item = xi.item.NETHERPACT_CHAIN,     cost =   5000 },
            [21] = { item = xi.item.BALRAHNS_EYEPATCH,    cost = 100000 },
            [22] = { item = xi.item.VALKYRIES_TEAR,       cost =   1000 },
            [23] = { item = xi.item.VALKYRIES_WING,       cost =   2000 },
            [24] = { item = xi.item.VALKYRIES_SOUL,       cost =   3000 },
        }

        local row = kilushaItems[option]

        if
            player:getFreeSlotsCount() ~= 0 and
            player:getCurrency('therion_ichor') >= row.cost
        then
            npcUtil.giveItem(player, row.item)
            player:delCurrency('therion_ichor', row.cost)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, row.item)
        end
    end
end

return entity
