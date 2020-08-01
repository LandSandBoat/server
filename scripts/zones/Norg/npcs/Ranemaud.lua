-----------------------------------
-- Area: Norg
--  NPC: Ranemaud
-- Involved in Quest: Forge Your Destiny, The Sacred Katana
-- !pos 15 0 23 252
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
local ID = require("scripts/zones/Norg/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    local questItem = player:getCharVar("ForgeYourDestiny_Event")
    local checkItem = testflag(tonumber(questItem), 0x02)

    if (checkItem == true) then
        if (trade:hasItemQty(738, 1) and trade:hasItemQty(737, 2) and trade:getItemCount() == 3) then
            player:startEvent(43, 0, 0, 738, 737) -- Platinum Ore, Gold Ore
        end
    end

    if (player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.THE_SACRED_KATANA) == QUEST_ACCEPTED and player:hasItem(17809) == false) then
        if (trade:getGil() == 30000 and trade:getItemCount() == 1 and player:getFreeSlotsCount() >= 1) then
            player:startEvent(145)
        end
    end

end

-----------------------------------
-- Event Check
-----------------------------------

function testflag(set, flag)
    return (set % (2*flag) >= flag)
end

function onTrigger(player, npc)

    local swordTimer = player:getCharVar("ForgeYourDestiny_timer")

    if (player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.FORGE_YOUR_DESTINY) == QUEST_ACCEPTED and swordTimer == 0) then
        if (player:hasItem(1153)) then
            player:startEvent(48, 1153) -- Sacred Branch
        elseif (player:hasItem(1198) == false) then
            local questItem = player:getCharVar("ForgeYourDestiny_Event")
            local checkItem = testflag(tonumber(questItem), 0x02)

            if (checkItem == false) then
                player:startEvent(40, 1153, 1198) -- Sacred Branch, Sacred Sprig
            elseif (checkItem == true) then
                player:startEvent(42, 0, 0, 738, 737) -- Platinum Ore, Gold Ore
            end
        elseif (player:hasItem(1198)) then -- Sacred Sprig
            player:startEvent(41)
        end
    elseif (player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.THE_SACRED_KATANA) == QUEST_ACCEPTED and player:hasItem(17809) == false) then
        player:startEvent(144)
    else
        player:startEvent(68)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    local questItem = player:getCharVar("ForgeYourDestiny_Event")

    if (csid == 40) then
        if (player:getFreeSlotsCount(0) >= 1) then
            player:addItem(1198)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1198) -- Sacred Sprig
            player:setCharVar("ForgeYourDestiny_Event", questItem + 0x02)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1151) -- Oriental Steel
        end
    elseif (csid == 43) then
        if (player:getFreeSlotsCount(0) >= 1) then
            player:tradeComplete()
            player:addItem(1198)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1198) -- Sacred Sprig
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1198) -- Sacred Sprig
        end
    elseif (csid == 145) then
        player:tradeComplete()
        player:addItem(17809)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 17809) -- Mumeito
    end

end
