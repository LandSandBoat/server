-----------------------------------
-- func: chef <itemname>
-- desc: Purchases a food item from the server.
-----------------------------------

cmdprops =
{
    permission = 0,
    parameters = "s"
}

function purchaseItem(player,itemId, price)
    local ID = zones[player:getZoneID()]
    local playerGil = player:getGil()
    if (playerGil > price) then
        player:delGil(price)
        player:PrintToPlayer("Thanks for your purchase.")
        player:addItem( itemId, 1)
        player:messageSpecial( ID.text.ITEM_OBTAINED, itemId )
    else
        player:PrintToPlayer("Not enough gil to complete purchase.")
    end
end

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!chef melonpie       (Melon Pie  2400g)")
    player:PrintToPlayer("!chef jacko    (Jack-o'-Lantern  3000g)")
    player:PrintToPlayer("!chef yagudo      (Yagudo drink  4000g)")
    player:PrintToPlayer("!chef solesushi     (Sole Sushi  6000g)")
    player:PrintToPlayer("!chef meatkabob (Meat Mithkabob  6000g)")
    player:PrintToPlayer("!chef tavtaco   (Tavnazian Taco 60000g)")
    player:PrintToPlayer("!chef behesteak   (Behemoth steak 80000g)")
end

function onTrigger(player, itemName)
    if (player:getFreeSlotsCount() == 0) then
        player:PrintToPlayer("ITEM CANNOT BE OBTAINED")
        return
    end
    if(itemName == "melonpie") then purchaseItem(player, 4421, 2400)
    elseif(itemName == "jacko") then purchaseItem(player, 4488, 3000)
    elseif(itemName == "yagudo") then purchaseItem(player, 4558,4000)
    elseif(itemName == "solesushi") then purchaseItem(player, 5149, 6000)
    elseif(itemName == "meatkabob") then purchaseItem(player, 4381, 6000)
    elseif(itemName == "tavtaco") then purchaseItem(player, 5174, 5000)
    elseif(itemName == "behesteak") then purchaseItem(player, 6464, 5000)
    else error(player,"Invalid item name") end
end