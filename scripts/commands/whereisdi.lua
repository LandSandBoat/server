---------------------------------------------------------------------------------------------------
-- func: whereisdi
-- desc: Sends you to the next Domain Battle
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
}

function onTrigger(player)
    if GetServerVariable("[Domain]NM") == 0 then
        player:PrintToPlayer("Apururu>> Domain invasion is currently active in Escha Ru'Aun", xi.msg.channel.TELL, xi.msg.channel.SYSTEM)
    end

    if GetServerVariable("[Domain]NM") == 1 then
        player:PrintToPlayer("Apururu>> Domain invasion is currently active in Reisenjima Henge", xi.msg.channel.TELL, xi.msg.channel.SYSTEM)
    end
    
	if GetServerVariable("[Domain]NM") == 2 or
        GetServerVariable("[Domain]NM") == 3 then
        player:PrintToPlayer("Apururu>> Domain invasion is currently active in Provenance", xi.msg.channel.TELL, xi.msg.channel.SYSTEM)
    end
end