-----------------------------------
-- Area: Southern Sandoria
--  NPC: Ominous Cloud
-- Type: Ninjutsu Toolbag Maker
-- !pos -41.550 1.999 -2.845 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local toolList =
    {
        {1161, 5308}, -- uchitake
        {1164, 5309}, -- tsurara
        {1167, 5310}, -- kawahori-ogi
        {1170, 5311}, -- makibishi
        {1173, 5312}, -- hiraishin
        {1176, 5313}, -- mizu-deppo
        {1179, 5314}, -- shihei
        {1182, 5315}, -- jusatsu
        {1185, 5316}, -- kaginawa
        {1188, 5317}, -- sairui-ran
        {1191, 5318}, -- kodoku
        {1194, 5319}, -- shinobi-tabi
        {2553, 5417}, -- sanjaku-tenugui
        {2555, 5734}, -- soshi
        {2642, 5863}, -- kabenro
        {2643, 5864}, -- jinko
        {2970, 5866}, -- mokujin
        {2971, 5867}, -- inoshishinofuda
        {2972, 5868}, -- shikanofuda
        {2973, 5869}, -- chonofuda

        {17301, 6299}, -- shuriken
        {17302, 6297}, -- juji shuriken
        {17303, 6298}, -- manji shuriken
        {17304, 6302}, -- fuma shuriken
        {18712, 6300}, -- koga shuriken
        {19783, 6303}, -- iga shuriken
        {21351, 6304}, -- roppo shuriken
        {21352, 6305}, -- roppo shuriken +1
        {21353, 6306}, -- happo shuriken
        {21354, 6307}, -- happo shuriken +1
        {21355, 6308}, -- hachiya shuriken
        {21356, 6309}, -- suppa shuriken
        {21357, 6301}, -- togakushi shuriken
        {22276, 6447}, -- sasuke shuriken
        {22277, 6448}, -- sasuke shuriken +1
    }

    local fruitNeeded = 0
    local giveToPlayer = {}

    -- check for invalid items
    for i = 0, 8, 1 do
        local itemId = trade:getItemId(i)
        if (itemId > 0 and itemId ~= 951) then
            local validSlot = false
            for k, v in pairs(toolList) do
                if (v[1] == itemId) then
                    local itemQty = trade:getSlotQty(i)
                    if (itemQty % 99 ~= 0) then
                        player:messageSpecial(ID.text.CLOUD_BAD_COUNT, 951)
                        return
                    end
                    local stacks = itemQty / 99
                    fruitNeeded = fruitNeeded + stacks
                    giveToPlayer[#giveToPlayer+1] = {v[2], stacks}
                    validSlot = true
                    break
                end
            end
            if (not validSlot) then
                player:messageSpecial(ID.text.CLOUD_BAD_ITEM)
                return
            end
        end
    end

    -- check for correct number of wijnfruit
    if (fruitNeeded == 0 or trade:getItemQty(951) ~= fruitNeeded) then
        player:messageSpecial(ID.text.CLOUD_BAD_COUNT, 951)
        return
    end

    -- check for enough inventory space
    if (player:getFreeSlotsCount() < fruitNeeded) then
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, giveToPlayer[1][1])
        return
    end

    -- make the trade
    player:messageSpecial(ID.text.CLOUD_GOOD_TRADE)
    for k, v in pairs(giveToPlayer) do
        player:addItem(v[1], v[2])
        player:messageSpecial(ID.text.ITEM_OBTAINED, v[1])
    end
    player:tradeComplete()
end

entity.onTrigger = function(player, npc)
    player:startEvent(759, npc:getID())
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
