-----------------------------------
-- Area: Heavens Tower
--  NPC: Mhabi Molkot
-- Quest: Ballista
-----------------------------------
local ID = zones[xi.zone.HEAVENS_TOWER]
-----------------------------------
---@type TNpcEntity
local entity = {}

local ballistaLicenseVar = 'BallistaLicense'

local startBallistaMenu = function(player)
    local ballistaKeyItems = (player:hasKeyItem(xi.ki.BALLISTA_LICENSE) and 1 or 0) +
        (player:hasKeyItem(xi.ki.BALLISTA_EARRING) and 2 or 0)

    player:startEvent(420, ballistaKeyItems)
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

    -- The player is from Windy and got the Ballista License
    if
        nation == xi.nation.WINDURST and
        (windurstApproval or player:hasKeyItem(xi.ki.BALLISTA_LICENSE))
    then
        startBallistaMenu(player)
        return true
    end

    -- The player is from Windy and got the foreign cities done
    if
        nation == xi.nation.WINDURST and
        started and
        sandoriaApproval and
        bastokApproval and
        not windurstApproval
    then
        player:startEvent(419)
        return true
    end

    -- The player is from Windy and has completed all required approvals
    if
        nation == xi.nation.WINDURST and
        started and
        sandoriaApproval and
        bastokApproval and
        windurstApproval
    then
        player:startEvent(420)
        return true
    end

    -- Player is from Windy and accepted the quest but didn't complete the cities
    if
        nation == xi.nation.WINDURST and
        started and
        (not sandoriaApproval or not bastokApproval)
    then
        player:startEvent(415)
        return true
    end

    -- Player is from Windy and has not started the quest
    if
        nation == xi.nation.WINDURST and
        not started and
        not applicationOffered and
        player:getRank(xi.nation.WINDURST) >= 3 and
        not player:hasKeyItem(xi.ki.BALLISTA_LICENSE)
    then
        player:startEvent(413)
        return true
    end

    -- Player is from Windy and has not started the quest but saw the CS
    if
        nation == xi.nation.WINDURST and
        not started and
        applicationOffered and
        player:getRank(xi.nation.WINDURST) >= 3 and
        not player:hasKeyItem(xi.ki.BALLISTA_LICENSE)
    then
        player:startEvent(414)
        return true
    end

    -- Player from Sandy or Bastok who has started the quest but hasn't received Windy approval
    if
        (nation == xi.nation.SANDORIA or
        nation == xi.nation.BASTOK) and
        started and
        not windurstApproval
    then
        player:startEvent(425)
        return true
    end

    -- Player is from Sandy got the approval and still has the letter
    if
        nation == xi.nation.SANDORIA and
        windurstApproval and
        player:hasKeyItem(xi.ki.LETTER_TO_THE_WIN_CONFLICT_CMD1)
    then
        player:startEvent(421)
        return true
    end

    -- Player is from Sandy and got the Windy approval and letter was given (trash talk)
    if
        nation == xi.nation.SANDORIA and
        windurstApproval and
        not player:hasKeyItem(xi.ki.LETTER_TO_THE_WIN_CONFLICT_CMD1)
    then
        player:startEvent(424)
        return true
    end

    -- Player is from Bastok got the approval and still has the letter
    if
        nation == xi.nation.BASTOK and
        started and
        windurstApproval and
        player:hasKeyItem(xi.ki.LETTER_TO_THE_WIN_CONFLICT_CMD2)
    then
        player:startEvent(422)
        return true
    end

    -- Player is from Bastok and got the Windy approval and letter was given (trash talk)
    if
        nation == xi.nation.BASTOK and
        started and
        windurstApproval and
        not player:hasKeyItem(xi.ki.LETTER_TO_THE_WIN_CONFLICT_CMD2)
    then
        player:startEvent(424, 1)
        return true
    end

    -- Player from Sandy or Bastok with License
    if
        (nation == xi.nation.BASTOK or
        nation == xi.nation.SANDORIA) and
        player:hasKeyItem(xi.ki.BALLISTA_LICENSE)
    then
        player:startEvent(424, 1, 1)
        return true
    end

    return false
end

local handleBallistaEventFinish = function(player, csid, option)
    if csid == 420 and option == 3 then
        npcUtil.giveKeyItem(player, xi.ki.BALLISTA_LICENSE)
        player:setCharVar(ballistaLicenseVar, 0)
    elseif
        csid == 420 and
        option == 1 and
        not player:hasKeyItem(xi.ki.BALLISTA_EARRING)
    then
        npcUtil.giveKeyItem(player, xi.ki.BALLISTA_EARRING)
    elseif
        csid == 420 and
        option == 2 and
        player:hasKeyItem(xi.ki.BALLISTA_EARRING)
    then
        player:delKeyItem(xi.ki.BALLISTA_EARRING)
    elseif csid == 419 then
        player:setCharVar(ballistaLicenseVar, utils.mask.setBit(player:getCharVar(ballistaLicenseVar), 4, true))
    elseif (csid == 413 or csid == 414) and option == 1 then
        npcUtil.giveKeyItem(player, xi.ki.LETTER_TO_THE_BAS_CONFLICT_CMD1)
        npcUtil.giveKeyItem(player, xi.ki.LETTER_TO_THE_SAN_CONFLICT_CMD1)
        player:setCharVar(ballistaLicenseVar, utils.mask.setBit(player:getCharVar(ballistaLicenseVar), 0, true))
    elseif csid == 413 then
        player:setCharVar(ballistaLicenseVar, utils.mask.setBit(player:getCharVar(ballistaLicenseVar), 5, true))
    elseif csid == 421 then
        player:delKeyItem(xi.ki.LETTER_TO_THE_WIN_CONFLICT_CMD1)
        player:messageSpecial(ID.text.KEYITEM_HAND_OVER, xi.ki.LETTER_TO_THE_WIN_CONFLICT_CMD1)
    elseif csid == 422 then
        player:delKeyItem(xi.ki.LETTER_TO_THE_WIN_CONFLICT_CMD2)
        player:messageSpecial(ID.text.KEYITEM_HAND_OVER, xi.ki.LETTER_TO_THE_WIN_CONFLICT_CMD2)
    end
end

entity.onTrigger = function(player, npc)
    if handleBallistaTrigger(player) then
        return
    end

    player:startEvent(410)
end

entity.onEventFinish = function(player, csid, option, npc)
    handleBallistaEventFinish(player, csid, option)
end

return entity