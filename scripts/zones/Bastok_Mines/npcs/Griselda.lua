-----------------------------------
-- Area: Bastok Mines
--  NPC: Griselda
-- Standard Merchant NPC
-- !pos -25.749 -0.044 52.360 234
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/quests")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local WildcatBastok = player:getCharVar("WildcatBastok")

    if player:getQuestStatus(BASTOK, tpz.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not player:getMaskBit(WildcatBastok, 15)  then
        player:startEvent(507)
    else
        local stock =
        {
            4442, 360, 1,    -- Pineapple Juice
            4391,  21, 2,    -- Bretzel
            4490, 432, 2,    -- Pickled Herring
            4424, 990, 2,    -- Melon Juice
            4499,  90, 3,    -- Iron Bread
            4376, 108, 3,    -- Meat Jerky
            4509,  10, 3,    -- Distilled Water
        }

        player:showText(npc, ID.text.GRISELDA_SHOP_DIALOG)
        tpz.shop.nation(player, stock, tpz.nation.BASTOK)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 507 then
        player:setMaskBit(player:getCharVar("WildcatBastok"), "WildcatBastok", 15, true)
    end
end
