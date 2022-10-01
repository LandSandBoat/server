-----------------------------
-- func: !Chef
-- desc: opens a Chef Shop.
-----------------------------
require("scripts/globals/msg")
-----------------------------

cmdprops =
{
    permission = 0,
    parameters = "i"
}

function onTrigger(player,npc)
    if player:hasEnmity() then
        player:messageSystem(xi.msg.system.TRUST_NO_ENMITY)
        return -1
    else
        player:PrintToPlayer("Welcome to the one-stop Chef Shop!")
        stock =
        {
            4153, 8000, -- Antacid
    		4376, 2000, -- Meat Jerky
    		4381, 5000, -- Meat Mithkabob
    		5166, 7000, -- Couerl Sub
    		4456, 2000, -- Boiled Crab
    		4398, 5000, -- Fish Mithkabob
    		4561, 7000, -- Seafood Stew
    		4488, 2000, -- Jack-o-Lantern
    		5150, 5000, -- Tuna Sushi
    		5178, 7000, -- Dorado Sushi
    		4413, 2000, -- Apple Pie
    		4421, 2000, -- Melon Pie
    		5718, 7000, -- Cream Puff
    		4422, 2000, -- Orange Juice
    		4424, 5000, -- Melon Juice
    		4558, 7000  -- Yagudo Drink
        } 
        xi.shop.general(player, stock)
	end
end