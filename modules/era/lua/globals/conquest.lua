-----------------------------------
-- Era Outpost Teleport Payment Module - Removes conquest points as a payment option for outpost teleportation.
-- Added December 14th, 2011 : https://forum.square-enix.com/ffxi/threads/18132
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_outpost_teleport_payment', xi.pre(xi.expansion.VOIDWATCH))

-- The client menus always list the conquest point option. The server cannot hide it.
-- A reported balance of 0 makes the client refuse the option with its own error message.
m:addOverride('xi.conquest.vendorOnTrigger', function(player, vendorRegion, vendorEvent)
    local pNation = player:getNation()
    local owner   = GetRegionOwner(vendorRegion)
    local nation  = 0
    local fee     = xi.conquest.outpostFee(player, vendorRegion)

    if owner == pNation then
        nation = 1
    elseif xi.conquest.areAllies(pNation, owner) then
        nation = 2
    end

    player:setLocalVar('outpostCpNoticeShown', 0)
    player:startEvent(vendorEvent, nation, fee, 0, fee / 10, 0, 0, 0, 0)
end)

m:addOverride('xi.conquest.vendorOnEventUpdate', function(player, vendorRegion)
    local fee = xi.conquest.outpostFee(player, vendorRegion)

    -- The event also updates mid-warp on the gil path. Notify once per interaction.
    if player:getLocalVar('outpostCpNoticeShown') == 0 then
        player:setLocalVar('outpostCpNoticeShown', 1)
        player:printToPlayer('Outpost Teleportation using Conquest Points is out of era.', xi.msg.channel.SYSTEM_3)
    end

    player:updateEvent(player:getGil(), fee, 0, fee / 10, 0)
end)

m:addOverride('xi.conquest.vendorOnEventFinish', function(player, option, vendorRegion)
    -- Option 6 pays with conquest points.
    if option == 6 then
        return
    end

    super(player, option, vendorRegion)
end)

m:addOverride('xi.conquest.teleporterOnEventUpdate', function(player, csid, option, teleporterEvent)
    if csid == teleporterEvent then
        local region = option - 1073741829
        local fee    = xi.conquest.outpostFee(player, region)
        local cpFee  = fee / 10

        player:printToPlayer('Outpost Teleportation using Conquest Points is out of era.', xi.msg.channel.SYSTEM_3)
        player:updateEvent(player:getGil(), fee, 0, cpFee, 0)
    end
end)

m:addOverride('xi.conquest.teleporterOnEventFinish', function(player, csid, option, teleporterEvent)
    -- Options 1029-1047 pay with conquest points.
    if csid == teleporterEvent and option >= 1029 and option <= 1047 then
        return
    end

    super(player, csid, option, teleporterEvent)
end)
