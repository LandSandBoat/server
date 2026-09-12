-----------------------------------
-- Area: Metalworks
--  NPC: Door:President's Office
-- Quest: Ballista
-----------------------------------
---@type TNpcEntity
local entity = {}

local ballistaLicenseVar = 'BallistaLicense'

entity.onTrigger = function(player, npc)
    local ballistaProgress   = player:getCharVar(ballistaLicenseVar)
    local nation             = player:getNation()
    local started            = utils.mask.getBit(ballistaProgress, 0)
    local sandoriaApproval   = utils.mask.getBit(ballistaProgress, 1)
    local bastokApproval     = utils.mask.getBit(ballistaProgress, 2)
    local windurstApproval   = utils.mask.getBit(ballistaProgress, 3)
    local debriefComplete    = utils.mask.getBit(ballistaProgress, 4)
    local applicationOffered = utils.mask.getBit(ballistaProgress, 5)

    if
        nation == xi.nation.SANDORIA and
        started and
        not bastokApproval
    then
        player:startEvent(828)
    elseif
        nation == xi.nation.WINDURST and
        started and
        not bastokApproval
    then
        player:startEvent(829)
    elseif
        nation == xi.nation.BASTOK and
        debriefComplete and
        not bastokApproval
    then
        player:startEvent(827)
    else
        player:startEvent(604)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 828 then
        player:setCharVar(ballistaLicenseVar, utils.mask.setBit(player:getCharVar(ballistaLicenseVar), 2, true))
    elseif csid == 829 then
        player:setCharVar(ballistaLicenseVar, utils.mask.setBit(player:getCharVar(ballistaLicenseVar), 2, true))
    elseif csid == 827 then
        player:setCharVar(ballistaLicenseVar, utils.mask.setBit(player:getCharVar(ballistaLicenseVar), 2, true))
    end
end

return entity