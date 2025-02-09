-----------------------------------
-- func: sanction
-- desc: Casts sanction on the player.
-----------------------------------

local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = "is"
}

local allowedZones =
{
    xi.zone.AL_ZAHBI,
    xi.zone.AHT_URHGAN_WHITEGATE,
    xi.zone.NASHMAU,
}

commandObj.onTrigger = function(player)
    local currentZone = player:getZoneID()
    player:printToPlayer("NOTE: This command may only be used in cities.")

    for _, allowedZone in ipairs(allowedZones) do
        if currentZone == allowedZone then
            player:printToPlayer("Enjoy sanction!")
            player:delStatusEffectsByFlag(xi.effectFlag.INFLUENCE, true)
            player:addStatusEffect(xi.effect.SANCTION, 0, 0, 15000)
        end
    end
end

return commandObj
