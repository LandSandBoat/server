-----------------------------------
-- Area: Upper Jeuno
--  NPC: Finbarr
-- NOTE: Chocobo Breeding NPC (Dating, Honeymoon, Eggs, etc.)
-- !pos -52.427 8.199 98.468 244
--
-- CHOCOCARD_M          : !additem 2339
-- CHOCOCARD_F          : !additem 2342
-- VCS_HONEYMOON_TICKET : !additem 2344
--
-- Honeymoon ticket exdata:
-- 01 00 00 00 00 00 00 00 00 00 00 00 6B 09 72 2C 00 00 00 00 00 00 00 00
--  ^-- ticket type                     ^-- signature: PlanA
-----------------------------------
local ID = zones[xi.zone.UPPER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    --player:startEvent(10103)
end

entity.onTrigger = function(player, npc)
    --player:startEvent(10101, 0) -- Rambling about chocobo breeding (This CS is displayed when interacting for the first time, 10108 after)

    --player:startEvent(10102, 0) -- We might have a new egg tomorrow (CS)

    -- gourmet date, black + yellow chocobos
    --player:startEvent(10102, 1, 4608, 0, 0, 67108863, 11729120, 4095, 131105)

    -- gourmet date, 2x yellow chocobos
    --player:startEvent(10102, 1)

    -- sports date
    --player:startEvent(10102, 2)

    -- hiking date
    --player:startEvent(10102, 3)

    -- jeuno date
    --player:startEvent(10102, 4)

    player:startEvent(10103) -- I'm Finbarr, the chocoguy!

    --player:startEvent(10104) -- Thanks!

    --player:startEvent(10105) -- Waiting to hatch

    --player:startEvent(10106) -- A chick was born!

    --player:startEvent(10107) -- The chocobo laid an egg, take good care of it!

    --player:startEvent(10108) -- Purchase menu
end

entity.onEventFinish = function(player, csid, option, npc)
    -- 1: purchase gourmet
    -- 2: purchase sports
    -- 3: purchase hiking
    -- 4: purchase jeuno tour
    if csid == 10108 and option >= 1 and option <= 4 then
        if player:getGil() < 3500 then
            player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
            return
        end

        if
            player:getFreeSlotsCount() > 0 and
            not player:hasItem(xi.item.VCS_HONEYMOON_TICKET)
        then
            player:delGil(3500)
            local signatures = { 'PlanA', 'PlanB', 'PlanC', 'PlanD' }
            player:addItem({
                id = xi.item.VCS_HONEYMOON_TICKET,
                exdata = { [0] = option },
                signature = signatures[option]
            })
            player:messageSpecial(ID.text.YOU_OBTAIN_A_X, xi.item.VCS_HONEYMOON_TICKET)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.VCS_HONEYMOON_TICKET)
        end
    end
end

return entity
