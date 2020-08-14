-----------------------------------
-- Area: Norg
--  NPC: Aeka
-- Involved in Quest: Forge Your Destiny
-- !pos 4 0 -4 252
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
local ID = require("scripts/zones/Norg/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    local questItem = player:getCharVar("ForgeYourDestiny_Event")
    local checkItem = testflag(tonumber(questItem), 0x01)

    if (checkItem == true) then
        if (trade:hasItemQty(645, 1) and trade:getItemCount() == 1) then
            player:startEvent(47, 0, 1151, 645) -- Oriental Steel, Darksteel Ore
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
        if (player:hasItem(1152)) then
            player:startEvent(48, 1152) -- Bomb Steel
        elseif (player:hasItem(1151) == false) then
            local questItem = player:getCharVar("ForgeYourDestiny_Event")
            local checkItem = testflag(tonumber(questItem), 0x01)

            if (checkItem == false) then
                player:startEvent(44, 1152, 1151) -- Bomb Steel, Oriental Steel
            elseif (checkItem == true) then
                player:startEvent(46, 0, 1151, 645) -- Oriental Steel, Darksteel Ore
            end
        elseif (player:hasItem(1151)) then
            player:startEvent(45, 1152, 1151) -- Bomb Steel, Oriental Steel
        end
    elseif (swordTimer > 0) then
        player:startEvent(50)
    else
        player:startEvent(120)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    local questItem = player:getCharVar("ForgeYourDestiny_Event")

    if (csid == 44) then
        if (player:getFreeSlotsCount(0) >= 1) then
            player:addItem(1151)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1151) -- Oriental Steel
            player:setCharVar("ForgeYourDestiny_Event", questItem + 0x01)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1151) -- Oriental Steel
        end
    elseif (csid == 47) then
        if (player:getFreeSlotsCount(0) >= 1) then
            player:tradeComplete()
            player:addItem(1151)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1151) -- Oriental Steel
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1151) -- Oriental Steel
        end
    end

end
