-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Door:Great Hall
-- Quest: Ballista
-----------------------------------
local ID = zones[xi.zone.CHATEAU_DORAGUILLE]
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
        debriefComplete and
        not sandoriaApproval
    then
        player:startEvent(70)
    elseif
        nation == xi.nation.BASTOK and
        started and
        not sandoriaApproval and
        player:hasKeyItem(xi.ki.LETTER_TO_THE_SAN_CONFLICT_CMD1)
    then
        player:startEvent(71)
    elseif
        nation == xi.nation.WINDURST and
        started and
        not sandoriaApproval and
        player:hasKeyItem(xi.ki.LETTER_TO_THE_SAN_CONFLICT_CMD1)
    then
        player:startEvent(72)
    else
        player:messageSpecial(ID.text.ITS_LOCKED_TIGHT)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 70 then
        player:setCharVar(ballistaLicenseVar, utils.mask.setBit(player:getCharVar(ballistaLicenseVar), 1, true))
    elseif csid == 71 or csid == 72 then
        player:setCharVar(ballistaLicenseVar, utils.mask.setBit(player:getCharVar(ballistaLicenseVar), 1, true))
    end
end

return entity