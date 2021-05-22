-----------------------------------
-- func: campaign helper
-----------------------------------
require("scripts/globals/campaign")
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "sii"
}

function onTrigger(player, arg0Str, arg1Int, arg2Int)
    local zone = player:getZone()
    local zoneID = player:getZoneID()

    -- Validate zone
    local found = false
	for i, id in pairs(xi.campaign.zone) do
		if id == zoneID then
			found = true
			break
		end
	end
    if not found then
        player:PrintToPlayer(string.format("You can only use campaign tools in campaign zones"))
        return
    end

    -- Start/Stop
    if arg0Str == "start" or arg0Str == "begin" then
        xi.campaign.startCampaign(zone)
    elseif arg0Str == "stop" or arg0Str == "end" then
        xi.campaign.endCampaign(zone)

    -- Battle Status
    elseif arg0Str == "status" then
        if arg1Int ~= nil then
            zone:setCampaignBattleStatus(arg1Int)
        end
        local status = zone:getCampaignBattleStatus()
        player:PrintToPlayer(string.format("Campaign Battle Status: %i", status))

    -- Control
    elseif arg0Str == "control" then
        if arg1Int ~= nil then
            zone:setCampaignZoneControl(arg1Int)
        end
        local control = zone:getCampaignZoneControl()
        player:PrintToPlayer(string.format("Campaign Zone Control: %i", control))

    -- Fortification
    elseif arg0Str == "fortification" then
        if arg1Int ~= nil then
            zone:setCampaignMaxFortification(arg1Int)
            zone:setCampaignFortification(arg1Int)
        end
        local fortification = zone:getCampaignFortification()
        player:PrintToPlayer(string.format("Campaign Fortification: %i", fortification))

    -- Influence
    elseif arg0Str == "influence" then
        if arg1Int == nil then
            return
        end
        if arg2Int ~= nil then
            zone:setCampaignInfluence(arg1Int, arg2Int)
        end
        local influence = zone:getCampaignInfluence(arg1Int)
        player:PrintToPlayer(string.format("Campaign Influence: Army: %i, Value: %i", arg1Int, influence))
    end

    SendCampaignUpdate(player)
end
