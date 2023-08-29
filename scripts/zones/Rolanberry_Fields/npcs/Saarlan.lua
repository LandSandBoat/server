-----------------------------------
-- Area: Rolanberry Fields
--  NPC: Saarlan
-- Legion NPC
-- !pos 242 24.395 468 110
-----------------------------------
local ID = zones[xi.zone.ROLANBERRY_FIELDS]
-----------------------------------
local entity = {}

local wares =
{
    [0x0001000A] = { ki = xi.ki.LEGION_TOME_PAGE_MAXIMUS, gil = 360000 }, -- Legion Tome Page Maximus
    [0x0001000B] = { ki = xi.ki.LEGION_TOME_PAGE_MINIMUS, gil = 180000 }, -- Legion Tome Page Minimus

    [0x00000002] = { item = 10775, lp = 1000 }, -- Gaiardas Ring
    [0x00010002] = { item = 10776, lp = 1000 }, -- Gaubious Ring
    [0x00020002] = { item = 10777, lp = 1000 }, -- Caloussu Ring
    [0x00030002] = { item = 10778, lp = 1000 }, -- Nanger Ring
    [0x00040002] = { item = 10779, lp = 1000 }, -- Sophia Ring
    [0x00050002] = { item = 10780, lp = 1000 }, -- Quies Ring
    [0x00060002] = { item = 10781, lp = 1000 }, -- Cynosure Ring
    [0x00070002] = { item = 10782, lp = 1000 }, -- Ambuscade Ring
    [0x00080002] = { item = 10783, lp = 1000 }, -- Veneficium Ring

    [0x00090002] = { item = 10890, lp = 4500, title = xi.title.SUBJUGATOR_OF_THE_LOFTY   }, -- Calma Armet
    [0x000A0002] = { item = 10891, lp = 4500, title = xi.title.SUBJUGATOR_OF_THE_LOFTY   }, -- Mustela Mask
    [0x000B0002] = { item = 10892, lp = 4500, title = xi.title.SUBJUGATOR_OF_THE_LOFTY   }, -- Magavan Beret
    [0x000C0002] = { item = 10512, lp = 3000, title = xi.title.SUBJUGATOR_OF_THE_MIRED   }, -- Calma Gauntlets
    [0x000D0002] = { item = 10513, lp = 3000, title = xi.title.SUBJUGATOR_OF_THE_MIRED   }, -- Mustela Gloves
    [0x000E0002] = { item = 10514, lp = 3000, title = xi.title.SUBJUGATOR_OF_THE_MIRED   }, -- Magavan Mitts
    [0x000F0002] = { item = 11980, lp = 4500, title = xi.title.SUBJUGATOR_OF_THE_SOARING }, -- Calma Hose
    [0x00100002] = { item = 11981, lp = 4500, title = xi.title.SUBJUGATOR_OF_THE_SOARING }, -- Mustela Brais
    [0x00110002] = { item = 11982, lp = 4500, title = xi.title.SUBJUGATOR_OF_THE_SOARING }, -- Magavan Slops
    [0x00120002] = { item = 10610, lp = 3000, title = xi.title.SUBJUGATOR_OF_THE_VEILED  }, -- Calma Leggings
    [0x00130002] = { item = 10611, lp = 3000, title = xi.title.SUBJUGATOR_OF_THE_VEILED  }, -- Mustela Boots
    [0x00140002] = { item = 10612, lp = 3000, title = xi.title.SUBJUGATOR_OF_THE_VEILED  }, -- Magavan Clogs
    [0x00150002] = { item = 10462, lp = 10000, title = xi.title.LEGENDARY_LEGIONNAIRE    }, -- Calma Breastplate
    [0x00160002] = { item = 10463, lp = 10000, title = xi.title.LEGENDARY_LEGIONNAIRE    }, -- Mustela Harness
    [0x00170002] = { item = 10464, lp = 10000, title = xi.title.LEGENDARY_LEGIONNAIRE    }, -- Magavan Frock
    [0x00180002] = { item = 11044, lp = 3000, title = xi.title.SUBJUGATOR_OF_THE_LOFTY   }, -- Corybant Pearl
    [0x00190002] = { item = 11045, lp = 3000, title = xi.title.SUBJUGATOR_OF_THE_MIRED   }, -- Saviesa Pearl
    [0x001A0002] = { item = 11046, lp = 3000, title = xi.title.SUBJUGATOR_OF_THE_SOARING }, -- Ouesk Pearl
    [0x001B0002] = { item = 11047, lp = 3000, title = xi.title.SUBJUGATOR_OF_THE_SOARING }, -- Belatz Pearl
    [0x001C0002] = { item = 11048, lp = 3000, title = xi.title.SUBJUGATOR_OF_THE_VEILED  }, -- Cytherea Pearl
    [0x001D0002] = { item = 11049, lp = 3000, title = xi.title.SUBJUGATOR_OF_THE_VEILED  }, -- Myrddin Pearl
    [0x001E0002] = { item = 11050, lp = 3000, title = xi.title.SUBJUGATOR_OF_THE_VEILED  }, -- Puissant Pearl
    [0x001F0002] = { item = 10784, lp = 6000, title = xi.title.LEGENDARY_LEGIONNAIRE     }, -- Dhanurveda Ring
    [0x00200002] = { item = 10785, lp = 6000, title = xi.title.LEGENDARY_LEGIONNAIRE     }, -- Provocare Ring
    [0x00210002] = { item = 10786, lp = 6000, title = xi.title.LEGENDARY_LEGIONNAIRE     }, -- Mediator's Ring
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar('LegionStatus') == 0 then
        player:startEvent(8004)
    elseif player:getCharVar('LegionStatus') == 1 then
        local maximus = player:hasKeyItem(xi.ki.LEGION_TOME_PAGE_MAXIMUS) and 1 or 0
        local minimus = player:hasKeyItem(xi.ki.LEGION_TOME_PAGE_MINIMUS) and 1 or 0
        local title =
            (player:hasTitle(xi.title.SUBJUGATOR_OF_THE_LOFTY)   and  1 or 0) +
            (player:hasTitle(xi.title.SUBJUGATOR_OF_THE_MIRED)   and  2 or 0) +
            (player:hasTitle(xi.title.SUBJUGATOR_OF_THE_SOARING) and  4 or 0) +
            (player:hasTitle(xi.title.SUBJUGATOR_OF_THE_VEILED)  and  8 or 0) +
            (player:hasTitle(xi.title.LEGENDARY_LEGIONNAIRE)     and 16 or 0)

        player:startEvent(8005, 0, title, maximus, player:getCurrency('legion_point'), minimus)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 8004 then
        player:setCharVar('LegionStatus', 1)
    elseif csid == 8005 then
        local ware = wares[option]

        if ware then
            -- can player afford this item?
            local afford = false

            if ware.gil then
                if player:getGil() >= ware.gil then
                    afford = true
                else
                    player:messageSpecial(ID.text.NOT_ENOUGH_GIL)
                end
            elseif ware.lp then
                if player:getCurrency('legion_point') >= ware.lp then
                    afford = true
                else
                    player:messageSpecial(ID.text.LACK_LEGION_POINTS)
                end
            end

            -- if player can afford, and has the required title, attempt to give them the item/ki
            local received = false

            if afford and (not ware.title or player:hasTitle(ware.title)) then
                if ware.item and npcUtil.giveItem(player, ware.item) then
                    received = true
                elseif ware.ki and npcUtil.giveKeyItem(player, ware.ki) then
                    received = true
                end
            end

            -- if they received the item/ki, make the payment
            if received then
                if ware.gil then
                    player:delGil(ware.gil)
                elseif ware.lp then
                    player:delCurrency('legion_point', ware.lp)
                end
            end
        end
    end
end

return entity
