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
        player:PrintToPlayer("{Apururu} Unity intelligence reports indicate a domain invasion is imminent in Kamihr Drifts.", xi.msg.channel.SYSTEM_3)
    end

    if GetServerVariable("[Domain]NM") == 1 then
        player:PrintToPlayer("{Apururu} Unity intelligence reports indicate a domain invasion is imminent in Reisenjima Henge.", xi.msg.channel.SYSTEM_3)
    end
    
	if GetServerVariable("[Domain]NM") == 2 or
        GetServerVariable("[Domain]NM") == 3 then
        player:PrintToPlayer("{Apururu} Unity intelligence reports indicate a domain invasion is imminent in Provenance.", xi.msg.channel.SYSTEM_3)
    end
end