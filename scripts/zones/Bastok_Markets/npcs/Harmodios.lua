-----------------------------------
-- Area: Bastok Markets
--  NPC: Harmodios
-- Standard Merchant NPC
-- !pos -79.928 -4.824 -135.114 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/quests")
require("scripts/globals/shop")

function onTrigger(player, npc)
    local WildcatBastok = player:getCharVar("WildcatBastok")

    if player:getQuestStatus(BASTOK, tpz.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not player:getMaskBit(WildcatBastok, 10) then
        player:startEvent(430)
    elseif player:getCharVar("comebackQueenCS") == 1 then
        player:startEvent(490)
    else
        local stock =
        {
            17347,   990, 1,    -- Piccolo
            17344,   219, 2,    -- Cornette
            17353,    43, 2,    -- Maple Harp
            5041,  69120, 2,    -- Scroll of Vital Etude
            5042,  66240, 2,    -- Scroll of Swift Etude
            5043,  63360, 2,    -- Scroll of Sage Etude
            5044,  56700, 2,    -- Scroll of Logical Etude
            5039,  79560, 2,    -- Scroll of Herculean Etude
            5040,  76500, 2,    -- Scroll of Uncanny Etude
            17351,  4644, 3,    -- Gemshorn
            17345,    43, 3,    -- Flute
            5045,  54000, 3,    -- Scroll of Bewitching Etude
        }

        player:showText(npc, ID.text.HARMODIOS_SHOP_DIALOG)
        tpz.shop.nation(player, stock, tpz.nation.BASTOK)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 430 then
        player:setMaskBit(player:getCharVar("WildcatBastok"), "WildcatBastok", 10, true)
    elseif csid == 490 then
        player:startEvent(491)
    elseif csid == 491 then
        player:setCharVar("comebackQueenCS", 2)
    end
end
