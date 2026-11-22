-----------------------------------
-- Wedding Master NPCs
-----------------------------------
xi = xi or {}
xi.wedding = xi.wedding or {}

local certificateEvent    = 2001
local minimumLevel        = 20
local interactionDistance = 6
local nationVar           = 'WeddingCertificateNation'
local spouseVar           = 'WeddingSpouse'
local optionVar           = '[Wedding]CertificateOption'
local partnerVar          = '[Wedding]CertificatePartner'

-- Event 2001 uses 1-based issuing nations and gender-indexed ring flags.
-- https://github.com/sruon/FFXI-EventsDump/blob/9144db8ca6007e2b251e7b4272f8b09f7a6ca0d3/dumps/Chateau%20d%27Oraguille/17731673%20-%20Rembard.md#event-2001
local issuingNation =
{
    [xi.zone.CHATEAU_DORAGUILLE] = 1,
    [xi.zone.METALWORKS]         = 2,
    [xi.zone.HEAVENS_TOWER]      = 3,
}

local certificateItems =
{
    xi.item.SAN_DORIAN_MARRIAGE_CERTIFICATE,
    xi.item.BASTOKAN_MARRIAGE_CERTIFICATE,
    xi.item.WINDURSTIAN_MARRIAGE_CERTIFICATE,
}

local awardOption =
{
    NONE   = 0,
    LEGACY = 2,
    COUPLE = 4,
}

local legacyRingFlag = 4

local ringFlags =
{
    [xi.item.MATRIMONY_BAND] = 1,
    [xi.item.MATRIMONY_RING] = 2,
    [xi.item.WEDDING_RING]   = legacyRingFlag,
}

local function getRingFlags(player)
    return bit.bor(
        ringFlags[player:getEquipID(xi.slot.RING1)] or 0,
        ringFlags[player:getEquipID(xi.slot.RING2)] or 0)
end

local function getCertificateHistory(player, checkHeld)
    local nation = player:getCharVar(nationVar)
    if nation ~= 0 and not checkHeld then
        return nation, 0
    end

    local heldNation       = 0
    local heldCertificates = 0

    for index, itemId in ipairs(certificateItems) do
        if player:hasItem(itemId) then
            heldNation       = index
            heldCertificates = bit.bor(heldCertificates, bit.lshift(1, index - 1))
        end
    end

    -- Older certificates can identify the issuing nation, even when placed in a Mog House.
    if nation == 0 and heldCertificates ~= 0 then
        if heldCertificates ~= bit.lshift(1, heldNation - 1) then
            return nil, heldCertificates
        end

        nation = heldNation
        player:setCharVar(nationVar, nation)
    end

    return nation, heldCertificates
end

local function findPartner(player, npc, zoneId, spouseId, previousNation)
    if player:getPartySize() ~= 2 then
        return nil, 0
    end

    local playerId = player:getID()
    for _, member in ipairs(player:getParty()) do
        local memberId = member:getID()
        if
            memberId ~= playerId and
            member:isPC() and
            member:getZoneID() == zoneId and
            member:checkDistance(npc) <= interactionDistance and
            player:isPartyOfTwoWith(memberId)
        then
            local memberNation = getCertificateHistory(member, false)
            local memberSpouse = member:getCharVar(spouseVar)

            -- A certificate or an engraving cannot establish a missing spouse's identity.
            local originalCouple = spouseId == memberId and memberSpouse == playerId
            local newCouple = spouseId == 0 and memberSpouse == 0 and previousNation == 0 and memberNation == 0
            if memberNation and (originalCouple or newCouple) then
                return member, memberNation
            end

            break
        end
    end

    return nil, 0
end

local function getCertificateRequest(player, npc, zoneId, sendMenu)
    local nation = issuingNation[zoneId]
    local previousNation, heldCertificates = getCertificateHistory(player, true)
    local canClaim =
        heldCertificates == 0 and
        player:getMainLvl() >= minimumLevel and
        player:checkDistance(npc) <= interactionDistance and
        (previousNation == 0 or previousNation == nation)

    if not sendMenu and not canClaim then
        return nil, awardOption.NONE, nil
    end

    local equippedFlags    = getRingFlags(player)
    local gender           = player:getGender()
    local hasMatrimonyRing = bit.band(equippedFlags, bit.lshift(1, gender)) ~= 0

    local partner
    local spouseId      = player:getCharVar(spouseVar)
    local partnerFlags  = 0
    local partnerGender = 0
    local partnerNation = 0

    if sendMenu or hasMatrimonyRing or spouseId ~= 0 then
        partner, partnerNation = findPartner(player, npc, zoneId, spouseId, previousNation)
        if partner then
            partnerFlags  = getRingFlags(partner)
            partnerGender = partner:getGender()
        end
    end

    -- A legacy Wedding Ring permits a solo first issue. Later claims require the recorded spouse.
    if
        bit.band(equippedFlags, legacyRingFlag) ~= 0 and
        (previousNation ~= 0 or spouseId ~= 0) and
        (not partner or (partnerNation ~= 0 and partnerNation ~= nation))
    then
        equippedFlags = bit.band(equippedFlags, bit.bnot(legacyRingFlag))
    end

    local param
    if sendMenu then
        param = bit.bor(
            nation,
            bit.lshift(previousNation or 0, 2),
            bit.lshift(heldCertificates, 4),
            bit.lshift(equippedFlags, 7),
            bit.lshift(partnerFlags, 10),
            bit.lshift(partnerGender, 13),
            bit.lshift(partnerNation, 14))
    end

    if not canClaim then
        return param, awardOption.NONE, partner
    end

    -- The client checks the equipped Matrimony ring before the legacy ring.
    if not hasMatrimonyRing then
        if bit.band(equippedFlags, legacyRingFlag) ~= 0 then
            return param, awardOption.LEGACY, partner
        end

        return param, awardOption.NONE, partner
    end

    if
        partner and
        partnerGender ~= gender and
        bit.band(partnerFlags, bit.lshift(1, partnerGender)) ~= 0 and
        (partnerNation == 0 or partnerNation == nation)
    then
        return param, awardOption.COUPLE, partner
    end

    return param, awardOption.NONE, partner
end

xi.wedding.onTrigger = function(player, npc)
    local param, option, partner = getCertificateRequest(player, npc, player:getZoneID(), true)
    local partnerId = partner and partner:getID() or 0

    player:setLocalVar(optionVar, option)
    player:setLocalVar(partnerVar, partnerId)
    player:startEvent(certificateEvent, param, partnerId, minimumLevel)
end

xi.wedding.onEventFinish = function(player, csid, option, npc)
    if csid ~= certificateEvent then
        return
    end

    local expectedOption = player:getLocalVar(optionVar)
    local partnerId      = player:getLocalVar(partnerVar)

    player:setLocalVar(optionVar, 0)
    player:setLocalVar(partnerVar, 0)

    if option == awardOption.NONE or option ~= expectedOption then
        return
    end

    -- The other player may leave, unequip their ring or change during the menu.
    local zoneId = player:getZoneID()
    local _, currentOption, partner = getCertificateRequest(player, npc, zoneId, false)
    if currentOption ~= option then
        return
    end

    if option == awardOption.LEGACY and player:getCharVar(spouseVar) == 0 then
        partner = nil
    elseif not partner or partner:getID() ~= partnerId then
        return
    end

    local nation = issuingNation[zoneId]
    local itemId = certificateItems[nation]
    local ID     = zones[zoneId]

    if not player:issueWeddingCertificate(nation, partner) then
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, itemId)
        return
    end

    player:showText(npc, bit.bor(ID.text.ITEM_OBTAINED, 0x8000), itemId, 0, 0, 0, false, false, 6)
end
