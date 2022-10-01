--------------------------------------------------------------
-- func: !Chef
-- desc: opens a Chef Shop.
--------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = "i"
};

function onTrigger(player,npc)
    player:PrintToPlayer("Welcome to the one-stop Chef Shop!")
    stock =
    {
        4153, 8000, -- Antacid
    } 
    xi.shop.general(player, stock)
end