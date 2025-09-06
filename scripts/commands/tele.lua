---------------------------------------------------------------------------------------------------
-- func: tele
-- auth: Jef (Iienji)
-- desc: teleports char
---------------------------------------------------------------------------------------------------
require("scripts/globals/teleports")
---------------------------------------------------------------------------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = "s"
}

commandObj.onTrigger = function(player,tele)
	if (player:getAnimation() == 44) then
		player:printToPlayer('You cannot do that while crafting. Cheater.')
		return
	end

    if(player:getZoneID() == 26 or player:getZoneID() == 48 or player:getZoneID() == 94 or player:getZoneID() == 80 or player:getZoneID() == 87  or player:getZoneID() == 50 or player:getZoneID() == 53 or player:getZoneID() >= 230 and player:getZoneID() <= 257) then

        if(tele == "altep") then
            if (player:hasKeyItem(xi.ki.ALTEPA_GATE_CRYSTAL) == true) then
                player:addStatusEffectEx(xi.effect.TELEPORT,0,xi.teleport.id.ALTEP,0,5)
                player:printToPlayer(string.format("Teleporting to Altep in 5 seconds."))
            else
                player:printToPlayer(string.format("Altepa Gate Crystal is required to use this teleport"))
            end
            return 0
        elseif(tele == "dem") then
            if (player:hasKeyItem(xi.ki.DEM_GATE_CRYSTAL) == true) then
                player:addStatusEffectEx(xi.effect.TELEPORT,0,xi.teleport.id.DEM,0,5)
                player:printToPlayer(string.format("Teleporting to Dem in 5 seconds."))
            else
                player:printToPlayer(string.format("Dem Gate Crystal is required to use this teleport"))
            end
            return 0
        elseif(tele == "holla") then
            if (player:hasKeyItem(xi.ki.HOLLA_GATE_CRYSTAL) == true) then
                player:addStatusEffectEx(xi.effect.TELEPORT,0,xi.teleport.id.HOLLA,0,5)
                player:printToPlayer(string.format("Teleporting to Holla in 5 seconds."))
            else
                player:printToPlayer(string.format("Holla Gate Crystal is required to use this teleport"))
            end
            return 0
        elseif(tele == "mea") then
            if (player:hasKeyItem(xi.ki.MEA_GATE_CRYSTAL) == true) then
                player:addStatusEffectEx(xi.effect.TELEPORT,0,xi.teleport.id.MEA,0,5)
                player:printToPlayer(string.format("Teleporting to Mea in 5 seconds."))
            else
                player:printToPlayer(string.format("Mea Gate Crystal is required to use this teleport"))
            end
            return 0
        elseif(tele == "vahzl") then
            if (player:hasKeyItem(xi.ki.VAHZL_GATE_CRYSTAL) == true) then
                player:addStatusEffectEx(xi.effect.TELEPORT,0,xi.teleport.id.VAHZL,0,5)
                player:printToPlayer(string.format("Teleporting to Vahzl in 5 seconds."))
            else
                player:printToPlayer(string.format("Vahzl Gate Crystal is required to use this teleport"))
            end
            return 0
        elseif(tele == "yhoat") then
            if (player:hasKeyItem(xi.ki.YHOATOR_GATE_CRYSTAL) == true) then
                player:addStatusEffectEx(xi.effect.TELEPORT,0,xi.teleport.id.YHOAT,0,5)
                player:printToPlayer(string.format("Teleporting to Yhoator in 5 seconds."))
            else
                player:printToPlayer("Yhoator Gate Crystal is required to use this teleport")
            end
            return 0
        elseif(tele == "jugner") then
            if (player:hasKeyItem(xi.ki.JUGNER_GATE_CRYSTAL) == true) then
                player:addStatusEffectEx(xi.effect.TELEPORT,0,xi.teleport.id.JUGNER,0,5)
                player:printToPlayer(string.format("Teleporting to Jugner in 5 seconds."))
            else
                player:printToPlayer(string.format("Jugner Gate Crystal is required to use this teleport"))
            end
            return 0
        elseif(tele == "meriph") then
            if (player:hasKeyItem(xi.ki.MERIPHATAUD_GATE_CRYSTAL) == true) then
                player:addStatusEffectEx(xi.effect.TELEPORT,0,xi.teleport.id.MERIPH,0,5)
                player:printToPlayer(string.format("Teleporting to Meriph in 5 seconds."))
            else
                player:printToPlayer(string.format("Meriphataud Gate Crystal is required to use this teleport"))
            end
            return 0
        elseif(tele == "pashow") then
            if (player:hasKeyItem(xi.ki.PASHHOW_GATE_CRYSTAL) == true) then
                player:addStatusEffectEx(xi.effect.TELEPORT,0,xi.teleport.id.PASHH,0,5)
                player:printToPlayer(string.format("Teleporting to Pashow in 5 seconds."))
            else
                player:printToPlayer(string.format("Pashow Gate Crystal is required to use this teleport"))
            end
            return 0
        else
            player:printToPlayer("Please enter a valid teleport. Command !tele loc")
            player:printToPlayer("Acceptable locs: holla, dem, mea, altep, yhoat, vahzl, jugner, meriph, pashow. [ex. !tele holla]")
            player:printToPlayer("Warning: Once you use the command, it cannot be cancelled. Use at own risk.")
            return
        end

    else
        player:printToPlayer("You may only use this command inside a city.")
    end
end

return commandObj
