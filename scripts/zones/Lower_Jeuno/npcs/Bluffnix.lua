-----------------------------------
-- Area: Lower Jeuno
--  NPC: Bluffnix
-- Starts and Finishes Quests: Gobbiebags I-X
-- !pos -43.099 5.900 -114.788 245
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    local count = trade:getItemCount()
    local gil = trade:getGil()
    local inventorySize = player:getContainerSize(0)
    local TheGobbieBag = gobQuest(player, inventorySize)
    local pFame = player:getFameLevel(JEUNO)

    if (count == 4 and gil == 0 and player:getQuestStatus(JEUNO, TheGobbieBag[1]) == 1) then
        if (player:getContainerSize(0) < 80) then
            if (trade:hasItemQty(TheGobbieBag[3], 1) and trade:hasItemQty(TheGobbieBag[4], 1) and trade:hasItemQty(TheGobbieBag[5], 1) and trade:hasItemQty(TheGobbieBag[6], 1)) then
                if (pFame >= TheGobbieBag[2]) then
                    player:startEvent(73, inventorySize+1)
                    offer = 1
                else
                    player:startEvent(43, inventorySize+1, questStatus, offer)
                end
            end
        else
            player:startEvent(43, 81) -- You're bag's bigger than any gobbie bag I've ever seen...
        end
    end
end

---------------------------------------------
-- Current Quest, Required Fame and Items
---------------------------------------------
function gobQuest(player, bagSize)
    currentQuest = {}
    switch (bagSize) : caseof {
        [30] = function (x) currentQuest = {27, 3, 0848, 0652, 0826, 0788}; end, --Gobbiebag I, Dhalmel Leather, Steel Ingot, Linen Cloth, Peridot
        [35] = function (x) currentQuest = {28, 4, 0851, 0653, 0827, 0798}; end, --Gobbiebag II, Ram Leather, Mythril Ingot, Wool Cloth, Turquoise
        [40] = function (x) currentQuest = {29, 5, 0855, 0745, 0828, 0797}; end, --Gobbiebag III, Tiger Leather, Gold Ingot, Velvet Cloth, Painite
        [45] = function (x) currentQuest = {30, 5, 0931, 0654, 0829, 0808}; end, --Gobbiebag IV, Cermet Chunk, Darksteel Ingot, Silk Cloth, Goshenite
        [50] = function (x) currentQuest = {74, 6, 1637, 1635, 1636, 1634}; end, --Gobbiebag V, Bugard Leather, Paktong Ingot, Moblinweave, Rhodonite
        [55] = function (x) currentQuest = {75, 6, 1741, 1738, 1739, 1740}; end, --Gobbiebag VI, HQ Eft Skin, Shakudo Ingot, Balloon Cloth, Iolite
        [60] = function (x) currentQuest = {93, 7, 2530, 0655, 0830, 0812}; end, --Gobbiebag VII, Lynx Leather, Adaman Ingot, Rainbow Cloth, Deathstone
        [65] = function (x) currentQuest = {94, 7, 2529, 2536, 2537, 0813}; end, --Gobbiebag VIII, Smilodon Leather, Electrum Ingot, Square of Cilice, Angelstone
        [70] = function (x) currentQuest = {123, 8, 2538, 0747, 2704, 2743}; end, --Gobbiebag IX, Peiste Leather, Orichalcum Ingot, Oil-Soaked Cloth, Oxblood Orb
        [75] = function (x) currentQuest = {124, 9, 1459, 1711, 2705, 2744}; end, --Gobbiebag X, Griffon Leather, Molybdenum Ingot, Foulard, Angelskin Orb
    default = function (x) end, }
    return currentQuest
end

function onTrigger(player, npc)

    local WildcatJeuno = player:getCharVar("WildcatJeuno")

    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatJeuno, 12) == false) then
        player:startEvent(10056)
    elseif (player:getContainerSize(0) < 80) then
        local pFame = player:getFameLevel(JEUNO)
        local inventorySize = player:getContainerSize(0)
        local TheGobbieBag = gobQuest(player, inventorySize)
        local questStatus = player:getQuestStatus(JEUNO, TheGobbieBag[1])

        offer = 0
        if (pFame >= TheGobbieBag[2]) then
            offer = 1
        end
        player:startEvent(43, inventorySize+1, questStatus, offer)
    else
        player:startEvent(43, 81) -- You're bag's bigger than any gobbie bag I've ever seen...
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    local TheGobbieBag = gobQuest(player, player:getContainerSize(0))

    if (csid == 43 and option == 0) then
        if (player:getQuestStatus(JEUNO, TheGobbieBag[1]) == 0) then
            player:addQuest(JEUNO, TheGobbieBag[1])
        end
    elseif (csid == 73) then
        if (gobbieBag == 5) then
            player:addTitle(tpz.title.GREEDALOX)
        elseif (gobbieBag == 10) then
            player:addTitle(tpz.title.GRAND_GREEDALOX)
        end

        player:changeContainerSize(tpz.inv.INVENTORY, 5)
        player:changeContainerSize(tpz.inv.MOGSATCHEL, 5)
        player:addFame(JEUNO, 30)
        player:tradeComplete()
        player:completeQuest(JEUNO, TheGobbieBag[1])
        player:messageSpecial(ID.text.INVENTORY_INCREASED)
    elseif (csid == 10056) then
        player:setMaskBit(player:getCharVar("WildcatJeuno"), "WildcatJeuno", 12, true)
    end
end
