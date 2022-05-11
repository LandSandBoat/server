---------------------------------------------------------------------------------------------------
-- func: FLY Like an EAGLE... TO THE SEA
-- desc: Tagban loves you.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = "s"
};

function error(player, msg)
    player:PrintToPlayer(msg);
    player:PrintToPlayer("!fly");
end;

function onTrigger(player, target)
    if (player:checkNameFlags(0x00000200)) then
        player:setFlag(0x00000200);
		player:speed(90);
		player:costume(0);
        player:PrintToPlayer( string.format("Fly turned off, wallhack off, speed normal, Costume off!.", player:getName()) );
    else
        player:setFlag(0x00000200);
        player:PrintToPlayer( string.format("FLYYYYYY LIKE AN EAGLE!!.", player:getName()) );
		player:setPos(player:getXPos(), -45, player:getZPos(), player:getRotPos());
		player:speed(220);
		player:costume(444);
    end
end
