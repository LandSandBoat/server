-----------------------------------
-- Matrimonial Coffer NPCs
-----------------------------------
xi = xi or {}
xi.matrimonialcoffer = xi.matrimonialcoffer or {}

local femaleStock =
{
    { price = 400000, items = { xi.item.BRIDAL_CORSAGE, xi.item.WEDDING_DRESS, xi.item.WEDDING_HOSE, xi.item.WEDDING_BOOTS } },
    { price =  80000, items = { xi.item.MATRIMONY_RING } },
}

local maleStock =
{
    { price = 200000, items = { xi.item.BENEDIGHT_COAT, xi.item.BENEDIGHT_HOSE } },
    { price = 100000, items = { xi.item.MATRIMONY_BAND } },
}

function xi.matrimonialcoffer.startEvent(player)
    local playerGender = player:getGender()
    local stock = playerGender == 0 and femaleStock or maleStock

    player:startEvent(2000, playerGender, stock[1].price, stock[2].items[1], stock[2].price, player:getGil())
end

function xi.matrimonialcoffer.finishEvent(player, csid, option, npc)
    if csid ~= 2000 then
        return
    end

    local stock = player:getGender() == 0 and femaleStock or maleStock
    local purchase = stock[option]
    if not purchase then
        return
    end

    local ID = zones[player:getZoneID()]
    if player:getGil() < purchase.price then
        player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
        return
    end

    local cannotObtain = bit.bor(ID.text.ITEM_CANNOT_BE_OBTAINED, 0x8000)

    -- Check the whole Rare attire set before adding pieces to the player's inventory.
    if option == 1 then
        for _, itemId in ipairs(purchase.items) do
            if player:hasItem(itemId) then
                player:showText(npc, cannotObtain, itemId, 0, 0, 0, false, false, 6)
                return
            end
        end
    end

    if not player:purchaseItems(purchase.items, purchase.price) then
        player:showText(npc, cannotObtain, purchase.items[1], 0, 0, 0, false, false, 6)
        return
    end

    local obtained = bit.bor(ID.text.ITEM_OBTAINED, 0x8000)
    for _, itemId in ipairs(purchase.items) do
        player:showText(npc, obtained, itemId, 0, 0, 0, false, false, 6)
    end
end
