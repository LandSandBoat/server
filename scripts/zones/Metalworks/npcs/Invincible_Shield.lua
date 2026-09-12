-----------------------------------
--  Area: Metalworks
--   NPC: Invincible Shield
-- Quest: Ballista
-----------------------------------
local ID = zones[xi.zone.METALWORKS]
-----------------------------------
---@type TNpcEntity
local entity = {}

local ballistaLicenseVar = 'BallistaLicense'

local startBallistaMenu = function(player)
    local ballistaKeyItems = 32 +
        (player:hasKeyItem(xi.ki.BALLISTA_LICENSE) and 1 or 0) +
        (player:hasKeyItem(xi.ki.BALLISTA_EARRING) and 2 or 0)

    player:startEvent(820, ballistaKeyItems, 131072, 0, 0, 288, 40411, 4095, 131088)
end

local handleBallistaTrigger = function(player)
    local ballistaProgress   = player:getCharVar(ballistaLicenseVar)
    local nation             = player:getNation()
    local started            = utils.mask.getBit(ballistaProgress, 0)
    local sandoriaApproval   = utils.mask.getBit(ballistaProgress, 1)
    local bastokApproval     = utils.mask.getBit(ballistaProgress, 2)
    local windurstApproval   = utils.mask.getBit(ballistaProgress, 3)
    local debriefComplete    = utils.mask.getBit(ballistaProgress, 4)
    local applicationOffered = utils.mask.getBit(ballistaProgress, 5)

    -- The player if from Bastok and got the Ballista License
    if
        nation == xi.nation.BASTOK and
        player:hasKeyItem(xi.ki.BALLISTA_LICENSE)
    then
        startBallistaMenu(player)
        return true
    end

    -- The player is from Bastok and completed both Cities and returning to Inv. Shield
    if
        nation == xi.nation.BASTOK and
        started and
        sandoriaApproval and
        windurstApproval and
        not bastokApproval
    then
        player:startEvent(819)
        return true
    end

    -- The player is from Bastok and has completed all required approvals
    if
        nation == xi.nation.BASTOK and
        started and
        sandoriaApproval and
        windurstApproval and
        bastokApproval
    then
        player:startEvent(820)
        return true
    end

    -- Player is from Bastok and accepted the quest but didn't complete the cities
    if
        nation == xi.nation.BASTOK and
        started and
        (player:hasKeyItem(xi.ki.LETTER_TO_THE_SAN_CONFLICT_CMD1) or
        player:hasKeyItem(xi.ki.LETTER_TO_THE_WIN_CONFLICT_CMD2))
    then
        player:startEvent(815)
        return true
    end

    -- Player is from Bastok and has not started the quest
    if
        nation == xi.nation.BASTOK and
        not started and
        not applicationOffered and
        player:getRank(xi.nation.BASTOK) >= 3 and
        not player:hasKeyItem(xi.ki.BALLISTA_LICENSE)
    then
        player:startEvent(813)
        return true
    end

    -- Player is from Bastok and has not started the quest but saw the CS
    if
        nation == xi.nation.BASTOK and
        not started and
        applicationOffered and
        player:getRank(xi.nation.BASTOK) >= 3 and
        not player:hasKeyItem(xi.ki.BALLISTA_LICENSE)
    then
        player:startEvent(814)
        return true
    end

    -- Player from Sandy or Windy who has started the quest but hasn't received Bastok approval
    if
        (nation == xi.nation.SANDORIA or
        nation == xi.nation.WINDURST) and
        started and
        not bastokApproval
    then
        player:startEvent(825)
        return true
    end

    -- Player is from Sandy got the approval and still has the letter
    if
        nation == xi.nation.SANDORIA and
        started and
        bastokApproval and
        player:hasKeyItem(xi.ki.LETTER_TO_THE_BAS_CONFLICT_CMD1)
    then
        player:startEvent(821)
        return true
    end

    -- Player is from Sandy and got the Bastok approval and letter was given (trash talk)
    if
        nation == xi.nation.SANDORIA and
        started and
        bastokApproval and
        not player:hasKeyItem(xi.ki.LETTER_TO_THE_BAS_CONFLICT_CMD1)
    then
        player:startEvent(824)
        return true
    end

    -- Player is from Windy got the approval and still has the letter
    if
        nation == xi.nation.WINDURST and
        started and
        bastokApproval and
        player:hasKeyItem(xi.ki.LETTER_TO_THE_BAS_CONFLICT_CMD1)
    then
        player:startEvent(823)
        return true
    end

    -- Player is from Windy and got the Bastok approval and letter was given (trash talk)
    if
        nation == xi.nation.WINDURST and
        started and
        bastokApproval and
        not player:hasKeyItem(xi.ki.LETTER_TO_THE_BAS_CONFLICT_CMD1)
    then
        player:startEvent(824, 2)
        return true
    end

    if
        (nation == xi.nation.WINDURST or
        nation == xi.nation.SANDORIA) and
        player:hasKeyItem(xi.ki.BALLISTA_LICENSE)
    then
        player:startEvent(824, 1, 1)
        return true
    end

    return false
end

local handleBallistaEventFinish = function(player, csid, option)
    if csid == 821 or csid == 823 then
        player:delKeyItem(xi.ki.LETTER_TO_THE_BAS_CONFLICT_CMD1)
        player:messageSpecial(ID.text.KEYITEM_HAND_OVER, xi.ki.LETTER_TO_THE_BAS_CONFLICT_CMD1)
    elseif (csid == 813 or csid == 814) and option == 1 then
        npcUtil.giveKeyItem(player, xi.ki.LETTER_TO_THE_SAN_CONFLICT_CMD1)
        npcUtil.giveKeyItem(player, xi.ki.LETTER_TO_THE_WIN_CONFLICT_CMD2)
        player:setCharVar(ballistaLicenseVar, utils.mask.setBit(player:getCharVar(ballistaLicenseVar), 0, true))
    elseif csid == 813 then
        player:setCharVar(ballistaLicenseVar, utils.mask.setBit(player:getCharVar(ballistaLicenseVar), 5, true))
    elseif csid == 819 then
        player:setCharVar(ballistaLicenseVar, utils.mask.setBit(player:getCharVar(ballistaLicenseVar), 4, true))
    elseif csid == 820 and option == 3 then
        npcUtil.giveKeyItem(player, xi.ki.BALLISTA_LICENSE)
        player:setCharVar(ballistaLicenseVar, 0)
    elseif
        csid == 820 and
        option == 1 and
        not player:hasKeyItem(xi.ki.BALLISTA_EARRING)
    then
        npcUtil.giveKeyItem(player, xi.ki.BALLISTA_EARRING)
    elseif
        csid == 820 and
        option == 2 and
        player:hasKeyItem(xi.ki.BALLISTA_EARRING)
    then
        player:delKeyItem(xi.ki.BALLISTA_EARRING)
    end
end

entity.onTrigger = function(player, npc)
    if handleBallistaTrigger(player) then
        return
    end

    player:startEvent(810)
end

entity.onEventFinish = function(player, csid, option, npc)
    handleBallistaEventFinish(player, csid, option)
end

return entity
