--------------------------------------------------------------
-- func: !Chef
-- desc: opens a Chef Shop.
--------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = "iiii"
};

function onTrigger(player,npc)
player:PrintToPlayer("Welcome to the one-stop Chef Shop!")
stock =
{
 4421, 2400, -- Melon Pie
 4488, 3000,-- Jaco
 4558, 4000, -- Yagudo
 5149, 6000, -- SoleSushi
 4381, 6000, -- MeatKabob
 5174, 5000, -- Tav-Taco
 6464, 5000, -- BeheSteak
} 
xi.shop.general(player, stock)
end