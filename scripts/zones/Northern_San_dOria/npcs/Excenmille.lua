-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Excenmille
-- Type: Trust NPC, Ballista Pursuivant
-- !pos -229.344 6.999 22.976 231
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

local ballistaLicenseVar = 'BallistaLicense'

local startBallistaMenu = function(player)
    local ballistaKeyItems = (player:hasKeyItem(xi.ki.BALLISTA_LICENSE) and 1 or 0) +
        (player:hasKeyItem(xi.ki.BALLISTA_EARRING) and 2 or 0)

    player:startEvent(32, ballistaKeyItems, 131328, 4106, 1, 66977791, 1886177, 4095, 1)
end

local trustMemory = function(player)
    local memories = 0
    if player:hasKeyItem(xi.ki.BALLISTA_LICENSE) then
        memories = memories + 2
    end

    -- 4 - Chocobo racing
    --  memories = memories + 4
    if player:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.CLAWS_OF_THE_GRIFFON) then
        memories = memories + 8
    end

    if player:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.BLOOD_OF_HEROES) then
        memories = memories + 16
    end

    return memories
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

    -- The player if from Sandy and got the Ballista License
    if
        nation == xi.nation.SANDORIA and
        (sandoriaApproval or player:hasKeyItem(xi.ki.BALLISTA_LICENSE))
    then
        startBallistaMenu(player)
        return true
    end

    -- The player if from Sandy and got the foreign cities done
    if
        nation == xi.nation.SANDORIA and
        started and
        bastokApproval and
        windurstApproval and
        not sandoriaApproval
    then
        player:startEvent(33)
        return true
    end

    -- The player is from Sandy and has completed all required approvals
    if
        nation == xi.nation.SANDORIA and
        started and
        windurstApproval and
        bastokApproval and
        sandoriaApproval
    then
        player:startEvent(32)
        return true
    end

    -- Player is from Sandy and accepted the quest but didn't complete the cities
    if
        nation == xi.nation.SANDORIA and
        started and
        (player:hasKeyItem(xi.ki.LETTER_TO_THE_BAS_CONFLICT_CMD1) or
        player:hasKeyItem(xi.ki.LETTER_TO_THE_WIN_CONFLICT_CMD1))
    then
        player:startEvent(34)
        return true
    end

    -- Player is from Sandy and has not started the quest
    if
        nation == xi.nation.SANDORIA and
        not started and
        not applicationOffered and
        player:getRank(xi.nation.SANDORIA) >= 3 and
        not player:hasKeyItem(xi.ki.BALLISTA_LICENSE)
    then
        player:startEvent(36)
        return true
    end

    -- Player is from Sandy and has not started the quest but saw the CS
    if
        nation == xi.nation.SANDORIA and
        not started and
        player:getRank(xi.nation.SANDORIA) >= 3 and
        applicationOffered and
        not player:hasKeyItem(xi.ki.BALLISTA_LICENSE)
    then
        player:startEvent(31)
        return true
    end

    -- Player from Bastok or Windy who has started the quest but hasn't received Sandy approval
    if
        (nation == xi.nation.BASTOK or
        nation == xi.nation.WINDURST) and
        started and
        not sandoriaApproval
    then
        player:startEvent(30)
        return true
    end

    -- Player from Bastok or Windy has the approbation and the Letter
    if
        started and
        sandoriaApproval and
        player:hasKeyItem(xi.ki.LETTER_TO_THE_SAN_CONFLICT_CMD1)
    then
        if nation == xi.nation.BASTOK then
            player:startEvent(26)
            return true
        elseif nation == xi.nation.WINDURST then
            player:startEvent(28)
            return true
        end
    end

    -- Player from Bastok got approval but not the Letter (talk trash)
    if
        nation == xi.nation.BASTOK and
        started and
        sandoriaApproval and
        not player:hasKeyItem(xi.ki.LETTER_TO_THE_SAN_CONFLICT_CMD1)
    then
        player:startEvent(35, 1)
        return true
    end

    -- Player from Windy got approuval and has the letter
    if
        nation == xi.nation.WINDURST and
        started and
        sandoriaApproval and
        player:hasKeyItem(xi.ki.LETTER_TO_THE_SAN_CONFLICT_CMD1)
    then
        player:startEvent(35)
        return true
    end

    -- Player from Windy got approuval but not the letter (talk trash)
    if
        nation == xi.nation.WINDURST and
        started and
        sandoriaApproval and
        not player:hasKeyItem(xi.ki.LETTER_TO_THE_SAN_CONFLICT_CMD1)
    then
        player:startEvent(35, 2)
        return true
    end

    -- Player from Bastok or Windy has the Ballista License
    if
        (nation == xi.nation.BASTOK or nation == xi.nation.WINDURST) and
        player:hasKeyItem(xi.ki.BALLISTA_LICENSE)
    then
        player:startEvent(35, 1, 1)
        return true
    end

    return false
end

local handleTrustTrigger = function(player)
    local trustSandoria = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.TRUST_SANDORIA)
    local trustBastok = player:getQuestStatus(xi.questLog.BASTOK, xi.quest.id.bastok.TRUST_BASTOK)
    local trustWindurst = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TRUST_WINDURST)
    local sandoriaFirstTrust = player:getCharVar('SandoriaFirstTrust')
    local excenmilleTrustChatFlag = player:getLocalVar('ExcenmilleTrustChatFlag')
    local rank3 = player:getRank(player:getNation()) >= 3 and 1 or 0

    if
        trustSandoria == xi.questStatus.QUEST_ACCEPTED and
        (trustWindurst == xi.questStatus.QUEST_COMPLETED or trustBastok == xi.questStatus.QUEST_COMPLETED)
    then
        player:startEvent(897, 0, 0, 0, trustMemory(player), 0, 0, 0, rank3)
        return true
    end

    if
        trustSandoria == xi.questStatus.QUEST_ACCEPTED and
        sandoriaFirstTrust == 0
    then
        player:startEvent(893, 0, 0, 0, trustMemory(player), 0, 0, 0, rank3)
        return true
    end

    if
        trustSandoria == xi.questStatus.QUEST_ACCEPTED and
        sandoriaFirstTrust == 1 and
        excenmilleTrustChatFlag == 0
    then
        player:startEvent(894)
        player:setLocalVar('ExcenmilleTrustChatFlag', 1)
        return true
    end

    if
        trustSandoria == xi.questStatus.QUEST_ACCEPTED and
        sandoriaFirstTrust == 2
    then
        player:startEvent(895)
        return true
    end

    if
        trustSandoria == xi.questStatus.QUEST_COMPLETED and
        not player:hasSpell(xi.magic.spell.CURILLA) and
        excenmilleTrustChatFlag == 0
    then
        player:startEvent(896, 0, 0, 0, 0, 0, 0, 0, rank3)
        player:setLocalVar('ExcenmilleTrustChatFlag', 1)
        return true
    end

    return false
end

local handleBallistaEventFinish = function(player, csid, option)
    if (csid == 36 or csid == 31) and option == 1 then
        npcUtil.giveKeyItem(player, xi.ki.LETTER_TO_THE_BAS_CONFLICT_CMD1)
        npcUtil.giveKeyItem(player, xi.ki.LETTER_TO_THE_WIN_CONFLICT_CMD1)
        player:setCharVar(ballistaLicenseVar, utils.mask.setBit(player:getCharVar(ballistaLicenseVar), 0, true))
    elseif csid == 36 then
        player:setCharVar(ballistaLicenseVar, utils.mask.setBit(player:getCharVar(ballistaLicenseVar), 5, true))
    elseif csid == 33 then
        player:setCharVar(ballistaLicenseVar, utils.mask.setBit(player:getCharVar(ballistaLicenseVar), 4, true))
    elseif
        csid == 32 and
        option == 3 and
        not player:hasKeyItem(xi.ki.BALLISTA_LICENSE)
    then
        npcUtil.giveKeyItem(player, xi.ki.BALLISTA_LICENSE)
        player:setCharVar(ballistaLicenseVar, 0)
        startBallistaMenu(player)
    elseif
        csid == 32 and
        option == 1 and
        not player:hasKeyItem(xi.ki.BALLISTA_EARRING)
    then
        npcUtil.giveKeyItem(player, xi.ki.BALLISTA_EARRING)
        startBallistaMenu(player)
    elseif csid == 32 and option == 2 and player:hasKeyItem(xi.ki.BALLISTA_EARRING) then
        player:delKeyItem(xi.ki.BALLISTA_EARRING)
    elseif csid == 26 or csid == 28 then
        player:delKeyItem(xi.ki.LETTER_TO_THE_SAN_CONFLICT_CMD1)
        player:messageSpecial(ID.text.KEYITEM_HAND_OVER, xi.ki.LETTER_TO_THE_SAN_CONFLICT_CMD1)
    else
        return false
    end

    return true
end

local handleTrustEventFinish = function(player, csid)
    if csid == 893 then
        player:addSpell(xi.magic.spell.EXCENMILLE, { silentLog = true })
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.EXCENMILLE)
        player:setCharVar('SandoriaFirstTrust', 1)
    elseif csid == 895 then
        player:delKeyItem(xi.ki.RED_INSTITUTE_CARD)
        player:messageSpecial(ID.text.KEYITEM_LOST, xi.ki.RED_INSTITUTE_CARD)
        npcUtil.completeQuest(player, xi.questLog.SANDORIA, xi.quest.id.sandoria.TRUST_SANDORIA, {
            keyItem = xi.ki.SAN_DORIA_TRUST_PERMIT,
            title = xi.title.THE_TRUSTWORTHY,
            var = 'SandoriaFirstTrust'
        })
        player:messageSpecial(ID.text.CALL_MULTIPLE_ALTER_EGO)
    elseif csid == 897 then
        player:addSpell(xi.magic.spell.EXCENMILLE, { silentLog = true })
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.EXCENMILLE)
        player:delKeyItem(xi.ki.RED_INSTITUTE_CARD)
        player:messageSpecial(ID.text.KEYITEM_LOST, xi.ki.RED_INSTITUTE_CARD)
        npcUtil.completeQuest(player, xi.questLog.SANDORIA, xi.quest.id.sandoria.TRUST_SANDORIA, {
            keyItem = xi.ki.SAN_DORIA_TRUST_PERMIT
        })
    end
end

entity.onTrigger = function(player, npc)
    if handleTrustTrigger(player) or handleBallistaTrigger(player) then
        return
    end

    player:startEvent(29)
end

entity.onEventFinish = function(player, csid, option, npc)
    if handleBallistaEventFinish(player, csid, option) then
        return
    end

    handleTrustEventFinish(player, csid)
end

return entity
