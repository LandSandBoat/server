-----------------------------------
-- Area: Port Jeuno
--  NPC: Synergy_Engineer
-- !pos  -52 0 -11 246
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
require("scripts/globals/status");
-----------------------------------
local entity = {}

local function handleQuantity(player, quantity)
    local random = math.random(1, 100)

    if random > 85 then
        quantity = 12
    elseif random > 65 then
        quantity = 9
    elseif random > 35 then
        quantity = 6
    else
        quantity = 3
    end

    return quantity
end

local function handleTradeSuccesful(player, itemId, quantity)
    player:tradeComplete();
    player:PrintToPlayer( "Engineer: Here you go, use it in the furnace.", 0xd );
    player:addItem(itemId,quantity);
    player:messageSpecial(ID.text.ITEM_OBTAINED, itemId);
end

entity.onTrade = function(player, npc, trade)
    --Initialize local variables.
    local itemId   = 0
    local quantity = 0

    -- *Seal of Genbu Scrap*
    if npcUtil.tradeHasExactly(trade, {1404}) and player:getFreeSlotsCount() >= 1 then
        itemId   = 3275
        quantity = handleQuantity(player, quantity)

        handleTradeSuccesful(player, itemId, quantity)

    -- *Seal of Suzaku Scrap*
    elseif npcUtil.tradeHasExactly(trade, {1407}) and player:getFreeSlotsCount() >= 1 then
        itemId   = 3276
        quantity = handleQuantity(player, quantity)

        handleTradeSuccesful(player, itemId, quantity)

    -- *Seal of Seiryu Scrap*
    elseif npcUtil.tradeHasExactly(trade, {1405}) and player:getFreeSlotsCount() >= 1 then
        itemId   = 3277
        quantity = handleQuantity(player, quantity)

        handleTradeSuccesful(player, itemId, quantity)

    -- *Seal of Byakko Scrap*
    elseif npcUtil.tradeHasExactly(trade, {1406}) and player:getFreeSlotsCount() >= 1 then
        itemId   = 3278
        quantity = handleQuantity(player, quantity)

        handleTradeSuccesful(player, itemId, quantity)

    -- *Aquarian Tatter*
    elseif
        (npcUtil.tradeHasExactly(trade, {1324}) or
        npcUtil.tradeHasExactly(trade, {1325}) or
        npcUtil.tradeHasExactly(trade, {1326}) or
        npcUtil.tradeHasExactly(trade, {1327}) or
        npcUtil.tradeHasExactly(trade, {1328})) and
        player:getFreeSlotsCount() >= 1
    then
        itemId   = 3283
        quantity = handleQuantity(player, quantity)

        handleTradeSuccesful(player, itemId, quantity)

    -- *Dryadic Tatter*
    elseif
        (npcUtil.tradeHasExactly(trade, {1314}) or
        npcUtil.tradeHasExactly(trade, {1315}) or
        npcUtil.tradeHasExactly(trade, {1316}) or
        npcUtil.tradeHasExactly(trade, {1317}) or
        npcUtil.tradeHasExactly(trade, {1318})) and
        player:getFreeSlotsCount() >= 1
    then
        itemId   = 3282
        quantity = handleQuantity(player, quantity)

        handleTradeSuccesful(player, itemId, quantity)

    -- *Earthen Tatter*
    elseif
        (npcUtil.tradeHasExactly(trade, {1319}) or
        npcUtil.tradeHasExactly(trade, {1320}) or
        npcUtil.tradeHasExactly(trade, {1321}) or
        npcUtil.tradeHasExactly(trade, {1322}) or
        npcUtil.tradeHasExactly(trade, {1323})) and
        player:getFreeSlotsCount() >= 1
    then
        itemId   = 3281
        quantity = handleQuantity(player, quantity)

        handleTradeSuccesful(player, itemId, quantity)

    -- *Hadean Tatter*
    elseif
        (npcUtil.tradeHasExactly(trade, {2434}) or
        npcUtil.tradeHasExactly(trade, {2435}) or
        npcUtil.tradeHasExactly(trade, {2436}) or
        npcUtil.tradeHasExactly(trade, {2437}) or
        npcUtil.tradeHasExactly(trade, {2438})) and
        player:getFreeSlotsCount() >= 1
    then
        itemId   = 3286
        quantity = handleQuantity(player, quantity)

        handleTradeSuccesful(player, itemId, quantity)

    -- *Martial Tatter*
    elseif
        (npcUtil.tradeHasExactly(trade, {1329}) or
        npcUtil.tradeHasExactly(trade, {1330}) or
        npcUtil.tradeHasExactly(trade, {1331}) or
        npcUtil.tradeHasExactly(trade, {1332}) or
        npcUtil.tradeHasExactly(trade, {1333})) and
        player:getFreeSlotsCount() >= 1
    then
        itemId   = 3280
        quantity = handleQuantity(player, quantity)

        handleTradeSuccesful(player, itemId, quantity)

    -- *Neptunal Tatter*
    elseif
        (npcUtil.tradeHasExactly(trade, {1339}) or
        npcUtil.tradeHasExactly(trade, {1340}) or
        npcUtil.tradeHasExactly(trade, {1341}) or
        npcUtil.tradeHasExactly(trade, {1342}) or
        npcUtil.tradeHasExactly(trade, {1343})) and
        player:getFreeSlotsCount() >= 1
    then
        itemId   = 3279
        quantity = handleQuantity(player, quantity)

        handleTradeSuccesful(player, itemId, quantity)

    -- *Phantasmal Tatter*
    elseif
        (npcUtil.tradeHasExactly(trade, {2429}) or
        npcUtil.tradeHasExactly(trade, {2430}) or
        npcUtil.tradeHasExactly(trade, {2431}) or
        npcUtil.tradeHasExactly(trade, {2432}) or
        npcUtil.tradeHasExactly(trade, {2433})) and
        player:getFreeSlotsCount() >= 1
    then
        itemId   = 3285
        quantity = handleQuantity(player, quantity)

        handleTradeSuccesful(player, itemId, quantity)

    -- *Wyrmal Tatter*
    elseif
        (npcUtil.tradeHasExactly(trade, {1334}) or
        npcUtil.tradeHasExactly(trade, {1335}) or
        npcUtil.tradeHasExactly(trade, {1336}) or
        npcUtil.tradeHasExactly(trade, {1337}) or
        npcUtil.tradeHasExactly(trade, {1338})) and
        player:getFreeSlotsCount() >= 1
    then
        itemId   = 3284
        quantity = handleQuantity(player, quantity)

        handleTradeSuccesful(player, itemId, quantity)

    else
        player:PrintToPlayer( "Engineer: What are you, stupid? That isn't what I asked for. Check that your pockets aren't full either.", 0xd );
    end
end

entity.onTrigger = function(player, npc)
    player:PrintToPlayer( "Engineer: So I hear you need some Scaps or Tatters?", 0xd );
    player:PrintToPlayer( "Engineer: Trade me the Seals of Genbu, Byakko, Suzaku or Seiryu, in return I will give you the Scraps.", 0xd );
    player:PrintToPlayer( "Engineer: You can also trade me the Abjuration in return I will give you the Tatter's.", 0xd );
    player:PrintToPlayer( "Engineer: I'll only accept them one by one, though. Tough luck.", 0xd );
    player:PrintToPlayer( "Engineer: Take your time, I will be here all week.", 0xd );
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
