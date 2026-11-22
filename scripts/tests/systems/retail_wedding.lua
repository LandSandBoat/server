local packetReader = require('scripts.tests.helpers.packet_reader')
local zoning       = require('scripts.tests.helpers.zoning')

describe('Wedding certificate officials', function()
    local certificateEventId = 2001
    local issuerVar          = 'WeddingCertificateNation'
    local spouseVar          = 'WeddingSpouse'

    local officials =
    {
        [xi.zone.CHATEAU_DORAGUILLE] = { name = 'Rembard',      nation = 1, certificate = xi.item.SAN_DORIAN_MARRIAGE_CERTIFICATE },
        [xi.zone.HEAVENS_TOWER]      = { name = 'Pompi-Rompi',  nation = 3, certificate = xi.item.WINDURSTIAN_MARRIAGE_CERTIFICATE },
        [xi.zone.METALWORKS]         = { name = 'Cloud_Walker', nation = 2, certificate = xi.item.BASTOKAN_MARRIAGE_CERTIFICATE },
    }

    local function getOfficial(player, name)
        local zone = assert(player:getZone())

        -- Heavens Tower has a cutscene-only Pompi-Rompi with the same name.
        for _, npc in ipairs(zone:queryEntitiesByName(name)) do
            if npc:getStatus() == xi.status.NORMAL then
                return npc
            end
        end

        error('Could not find the active wedding official ' .. name)
    end

    local function openMenu(player, official)
        local npc = getOfficial(player, official.name)
        player.packets:clear()
        player.entities:gotoAndTrigger(npc)

        local start = packetReader.lastEventStart(player)
        assert(start.actor == npc:getID(), 'the official did not start the event')
        assert(start.params[2] == 20, 'the displayed minimum level is wrong')

        return start.params, start.actor
    end

    local function spawnCouple(zoneId, level, signRings)
        local official = officials[zoneId]
        local bride    = xi.test.world:spawnPlayer({ zone = zoneId, race = xi.race.HUME_F, level = level or 20 })
        local groom    = xi.test.world:spawnPlayer({ zone = zoneId, race = xi.race.HUME_M, level = 20 })
        local npc      = getOfficial(bride, official.name)
        bride.entities:moveTo(npc)
        groom.entities:moveTo(npc)
        bride.actions:inviteToParty(groom)
        groom.actions:acceptPartyInvite()
        assert(bride:getPartySize() == 2, 'the couple did not form a party')

        bride:addItem({ id = xi.item.MATRIMONY_BAND, signature = signRings and groom:getName() or nil })
        groom:addItem({ id = xi.item.MATRIMONY_RING, signature = signRings and bride:getName() or nil })
        bride:equipItem(xi.item.MATRIMONY_BAND, nil, xi.slot.RING1)
        groom:equipItem(xi.item.MATRIMONY_RING, nil, xi.slot.RING2)
        assert(bride:getEquipID(xi.slot.RING1) == xi.item.MATRIMONY_BAND)
        assert(groom:getEquipID(xi.slot.RING2) == xi.item.MATRIMONY_RING)

        return bride, groom, official
    end

    it('advertises the same event and each issuing nation at its own official', function()
        for zoneId, official in pairs(officials) do
            local player = xi.test.world:spawnPlayer({ zone = zoneId, level = 20 })
            local params = openMenu(player, official)
            assert(params[0] == official.nation, 'the solo certificate mask is wrong')
            assert(params[1] == 0, 'the official signaled an absent partner')
            player.events:finish(certificateEventId, 1)
            player.assert.no:hasItem(official.certificate)
        end
    end)

    it('awards each partner an unsigned certificate when both confirm', function()
        local bride, groom, official = spawnCouple(xi.zone.CHATEAU_DORAGUILLE, 20, true)
        local params, actorId = openMenu(bride, official)
        assert(params[0] == 0x2881, 'the eligible bride flags differ from retail')
        assert(params[1] == groom:getID(), 'the groom is not identified')

        local groomParams = openMenu(groom, official)
        assert(groomParams[0] == 0x0501 and groomParams[1] == bride:getID(), 'the eligible groom flags differ from retail')
        bride.events:finish(certificateEventId, 4)

        local certificate = assert(bride:findItem(official.certificate), 'the bride received no certificate')
        assert(certificate:getSignature() == '', 'the captured certificate was unsigned')
        assert(bride:getCharVar(issuerVar) == official.nation, 'the issuer was not recorded')
        assert(bride:getCharVar(spouseVar) == groom:getID() and groom:getCharVar(spouseVar) == bride:getID())
        assert(bride:getEquipID(xi.slot.RING1) == xi.item.MATRIMONY_BAND, 'the official removed the ring')
        local announced = false
        for _, packet in ipairs(bride.packets:getIncoming()) do
            if
                packet.type == 0x02A and
                packetReader.readU32(packet.data, 0x04) == actorId and
                packetReader.readU32(packet.data, 0x08) == official.certificate and
                packetReader.readU16(packet.data, 0x1A) == 0x99CB and
                packet.data[0x1C] == 6
            then
                announced = true
                break
            end
        end

        assert(announced, 'the official did not announce the certificate as in retail')

        groom.assert.no:hasItem(official.certificate)
        assert(groom:getCharVar(issuerVar) == 0, 'the issuer was recorded before the groom confirmed')
        groom.events:finish(certificateEventId, 4)
        local groomCertificate = assert(groom:findItem(official.certificate), 'the groom received no certificate')
        assert(groomCertificate:getSignature() == '', 'the groom certificate was signed')
        assert(groom:getCharVar(issuerVar) == official.nation, 'the issuer was not recorded for the partner')

        params = openMenu(bride, official)
        assert(params[0] == 0x6895, 'the issued bride flags differ from retail')
        bride.events:finish(certificateEventId, 4)
        assert(bride:getItemCount(official.certificate) == 1, 'the official issued a duplicate certificate')

        groomParams = openMenu(groom, official)
        assert(groomParams[0] == 0x4515, 'the issued groom flags differ from retail')
        groom.events:finish(certificateEventId, 1)
    end)

    it('accepts the correct rings when neither partner engraves them', function()
        local bride, groom, official = spawnCouple(xi.zone.METALWORKS)
        assert(bride:getEquippedItem(xi.slot.RING1):getSignature() == '')
        assert(groom:getEquippedItem(xi.slot.RING2):getSignature() == '')

        openMenu(bride, official)
        bride.events:finish(certificateEventId, 4)
        bride.assert:hasItem(official.certificate)
    end)

    it('preserves the couple and both rings when the client cancels', function()
        local bride, groom, official = spawnCouple(xi.zone.CHATEAU_DORAGUILLE)
        openMenu(bride, official)
        bride.events:finish(certificateEventId, utils.EVENT_CANCELLED_OPTION)

        bride.assert.no:hasItem(official.certificate)
        groom.assert.no:hasItem(official.certificate)
        assert(bride:getCharVar(issuerVar) == 0 and groom:getCharVar(issuerVar) == 0)
        assert(bride:getCharVar(spouseVar) == 0 and groom:getCharVar(spouseVar) == 0)
        assert(bride:getEquipID(xi.slot.RING1) == xi.item.MATRIMONY_BAND)
        assert(groom:getEquipID(xi.slot.RING2) == xi.item.MATRIMONY_RING)
    end)

    it('refuses a confirmed result when the requesting character is below level 20', function()
        local bride, groom, official = spawnCouple(xi.zone.CHATEAU_DORAGUILLE, 19)
        openMenu(bride, official)
        bride.events:finish(certificateEventId, 4)

        bride.assert.no:hasItem(official.certificate)
        assert(bride:getCharVar(issuerVar) == 0 and groom:getCharVar(issuerVar) == 0)
    end)

    it('refuses a couple of the same character gender even when both wear their Matrimony Ring', function()
        local zoneId   = xi.zone.CHATEAU_DORAGUILLE
        local official = officials[zoneId]
        local first    = xi.test.world:spawnPlayer({ zone = zoneId, race = xi.race.HUME_M, level = 20 })
        local second   = xi.test.world:spawnPlayer({ zone = zoneId, race = xi.race.HUME_M, level = 20 })
        local npc      = getOfficial(first, official.name)
        first.entities:moveTo(npc)
        second.entities:moveTo(npc)
        first.actions:inviteToParty(second)
        second.actions:acceptPartyInvite()

        for _, player in ipairs({ first, second }) do
            player:addItem(xi.item.MATRIMONY_RING)
            player:equipItem(xi.item.MATRIMONY_RING, nil, xi.slot.RING1)
        end

        local params = openMenu(first, official)
        assert(params[1] == second:getID() and params[0] == 0x2901, 'expected both equipped rings and a nearby partner')
        first.events:finish(certificateEventId, 4)
        first.assert.no:hasItem(official.certificate)
        assert(first:getCharVar(issuerVar) == 0)
    end)

    it('does not offer a certificate when the party has a third player', function()
        local zoneId = xi.zone.CHATEAU_DORAGUILLE
        local bride, groom, official = spawnCouple(zoneId)
        local guest = xi.test.world:spawnPlayer({ zone = zoneId, level = 20 })

        bride.actions:inviteToParty(guest)
        guest.actions:acceptPartyInvite()
        assert(bride:getPartySize() == 3, 'the guest did not join the party')

        local params = openMenu(bride, official)
        assert(params[1] == 0, 'the official treated a three-person party as a couple')
        bride.events:finish(certificateEventId, 4)
        bride.assert.no:hasItem(official.certificate)
        groom.assert.no:hasItem(official.certificate)
    end)

    it('refuses a couple whose two-person party joins an alliance during the event', function()
        local zoneId = xi.zone.CHATEAU_DORAGUILLE
        local bride, groom, official = spawnCouple(zoneId)
        local leader = xi.test.world:spawnPlayer({ zone = zoneId })
        local guest  = xi.test.world:spawnPlayer({ zone = zoneId })

        leader.actions:inviteToParty(guest)
        guest.actions:acceptPartyInvite()
        assert(openMenu(groom, official)[1] == bride:getID())
        bride.actions:formAlliance(leader)
        leader.actions:acceptPartyInvite()
        assert(bride:getPartySize() == 2 and bride:getAllianceSize() == 4, 'the two parties did not form an alliance')

        assert(openMenu(bride, official)[1] == 0, 'the official offered a certificate to an allied couple')
        bride.events:finish(certificateEventId, 4)
        groom.events:finish(certificateEventId, 4)
        bride.assert.no:hasItem(official.certificate)
        groom.assert.no:hasItem(official.certificate)
        assert(bride:getCharVar(issuerVar) == 0 and groom:getCharVar(issuerVar) == 0)
    end)

    it('counts a third party member between zones at the menu and at confirmation', function()
        local zoneId = xi.zone.CHATEAU_DORAGUILLE
        local bride, groom, official = spawnCouple(zoneId)
        local guest = xi.test.world:spawnPlayer({ zone = zoneId })

        assert(openMenu(groom, official)[1] == bride:getID())
        bride.actions:inviteToParty(guest)
        guest.actions:acceptPartyInvite()
        assert(bride:getPartySize() == 3, 'the guest did not join the party')
        guest.network:drain()
        assert(zoning.zoneOut(guest, xi.zone.NORTHERN_SAN_DORIA) == 'login')
        assert(bride:getPartySize() == 2, 'the guest is still in the local roster')

        assert(openMenu(bride, official)[1] == 0, 'the official offered a certificate while the guest was zoning')
        bride.events:finish(certificateEventId, 4)
        groom.events:finish(certificateEventId, 4)
        bride.assert.no:hasItem(official.certificate)
        groom.assert.no:hasItem(official.certificate)
        assert(bride:getCharVar(issuerVar) == 0 and groom:getCharVar(issuerVar) == 0)
        guest.network:zoneIn()
    end)

    it('rejects a stale partner when the persisted party still has two players', function()
        local zoneId = xi.zone.CHATEAU_DORAGUILLE
        local bride, groom, official = spawnCouple(zoneId)
        local guest   = xi.test.world:spawnPlayer({ zone = zoneId })
        local guestId = guest:getID()

        bride.actions:inviteToParty(guest)
        assert(openMenu(bride, official)[1] == groom:getID())
        guest.actions:acceptPartyInvite()
        guest.network:drain()
        assert(zoning.zoneOut(guest, xi.zone.NORTHERN_SAN_DORIA) == 'login')

        -- A GM reset removes the groom's session and party row while his entity is still present.
        bride:resetPlayer(groom:getName())
        assert(bride:getPartySize() == 2, 'the local roster must still contain the original couple')
        assert(bride:isPartyOfTwoWith(guestId), 'the persisted party must consist of the bride and guest')
        bride.events:finish(certificateEventId, 4)
        bride.assert.no:hasItem(official.certificate)
        assert(bride:getCharVar(issuerVar) == 0)
        guest.network:zoneIn()
    end)

    it('reissues a lost certificate from the original officiant with the partner present', function()
        local bride, groom, official = spawnCouple(xi.zone.CHATEAU_DORAGUILLE)
        openMenu(bride, official)
        bride.events:finish(certificateEventId, 4)
        openMenu(groom, official)
        groom.events:finish(certificateEventId, 4)

        bride.assert:hasItem(official.certificate)
        groom.assert:hasItem(official.certificate)
        assert(bride:delItem(official.certificate, 1))

        local params = openMenu(bride, official)
        assert(params[0] == 0x6885 and params[1] == groom:getID(), 'the replacement mask is wrong')
        bride.events:finish(certificateEventId, 4)
        assert(bride:getItemCount(official.certificate) == 1, 'the official did not replace the missing certificate')
        assert(groom:getItemCount(official.certificate) == 1, 'the official duplicated the partner certificate')
    end)

    it('keeps both partners bound after only one has claimed a certificate', function()
        local zoneId = xi.zone.CHATEAU_DORAGUILLE
        local bride, groom, official = spawnCouple(zoneId)
        local otherBride, otherGroom = spawnCouple(zoneId)
        openMenu(bride, official)
        bride.events:finish(certificateEventId, 4)
        bride.assert:hasItem(official.certificate)
        assert(bride:delItem(official.certificate, 1))
        assert(groom:getCharVar(issuerVar) == 0)

        groom.actions:leaveParty()
        otherGroom.actions:leaveParty()
        bride.actions:inviteToParty(otherGroom)
        otherGroom.actions:acceptPartyInvite()
        groom.actions:inviteToParty(otherBride)
        otherBride.actions:acceptPartyInvite()

        -- The first couple cannot remarry, either as the claimant or as the accompanying partner.
        for _, player in ipairs({ bride, otherGroom, groom, otherBride }) do
            openMenu(player, official)
            player.events:finish(certificateEventId, 4)
            player.assert.no:hasItem(official.certificate)
        end

        assert(bride:getCharVar(spouseVar) == groom:getID() and groom:getCharVar(spouseVar) == bride:getID())
        assert(otherBride:getCharVar(spouseVar) == 0 and otherGroom:getCharVar(spouseVar) == 0)
    end)

    it('requires reciprocal spouse IDs when a former partner character ID is reused', function()
        local bride, groom, official = spawnCouple(xi.zone.CHATEAU_DORAGUILLE)
        bride:setCharVar(spouseVar, groom:getID())

        for _, player in ipairs({ bride, groom }) do
            openMenu(player, official)
            player.events:finish(certificateEventId, 4)
            player.assert.no:hasItem(official.certificate)
        end

        assert(bride:getCharVar(spouseVar) == groom:getID() and groom:getCharVar(spouseVar) == 0)
    end)

    it('rechecks the party after opening the event', function()
        local bride, groom, official = spawnCouple(xi.zone.CHATEAU_DORAGUILLE)
        openMenu(bride, official)
        groom.actions:leaveParty()
        bride.events:finish(certificateEventId, 4)

        bride.assert.no:hasItem(official.certificate)
        assert(bride:getCharVar(issuerVar) == 0 and groom:getCharVar(issuerVar) == 0)
    end)

    it('refuses a partner who moves outside the NPC interaction range during the event', function()
        local bride, groom, official = spawnCouple(xi.zone.CHATEAU_DORAGUILLE)
        assert(openMenu(bride, official)[1] == groom:getID(), 'the nearby partner was not found')
        groom:setPos(groom:getXPos() + 7, groom:getYPos(), groom:getZPos())
        bride.events:finish(certificateEventId, 4)
        bride.assert.no:hasItem(official.certificate)

        assert(openMenu(bride, official)[1] == 0, 'the distant partner was still included')
        bride.events:finish(certificateEventId, 4)
        bride.assert.no:hasItem(official.certificate)
        assert(bride:getCharVar(issuerVar) == 0 and groom:getCharVar(issuerVar) == 0)
    end)

    it('does not allow a different nation than the partner issuer', function()
        local bride, groom, official = spawnCouple(xi.zone.METALWORKS)
        local firstIssuer = officials[xi.zone.CHATEAU_DORAGUILLE].nation
        groom:setCharVar(issuerVar, firstIssuer)
        bride:setCharVar(spouseVar, groom:getID())
        groom:setCharVar(spouseVar, bride:getID())
        local params = openMenu(bride, official)
        assert(bit.band(bit.rshift(params[0], 14), 3) == firstIssuer, 'the partner issuer is not in the flags')
        bride.events:finish(certificateEventId, 4)

        bride.assert.no:hasItem(official.certificate)
        assert(bride:getCharVar(issuerVar) == 0)
        assert(groom:getCharVar(issuerVar) == firstIssuer)
    end)

    it('recovers the issuing nation from the original partner\'s certificate in Mog Safe', function()
        local sandy = officials[xi.zone.CHATEAU_DORAGUILLE]
        local bride, groom, bastok = spawnCouple(xi.zone.METALWORKS)
        groom:gotoMogHouse(xi.zone.BASTOK_MARKETS)
        if groom:isInEvent() then
            groom.events:finish()
        end

        groom:addItem(sandy.certificate)
        local item = assert(groom:findItem(sandy.certificate, xi.inv.INVENTORY))
        groom.actions:moveItem(xi.inv.INVENTORY, item:getSlotID(), xi.inv.MOGSAFE, 1)
        assert(groom:findItem(sandy.certificate, xi.inv.MOGSAFE))
        assert(groom:getCharVar(issuerVar) == 0)

        groom:gotoZone(xi.zone.METALWORKS)
        groom.entities:moveTo(getOfficial(groom, bastok.name))
        openMenu(bride, bastok)
        bride.events:finish(certificateEventId, 4)
        bride.assert.no:hasItem(bastok.certificate)
        assert(groom:getCharVar(issuerVar) == sandy.nation)
        assert(bride:getCharVar(spouseVar) == 0 and groom:getCharVar(spouseVar) == 0)

        bride:setCharVar(spouseVar, groom:getID())
        groom:setCharVar(spouseVar, bride:getID())
        local params = openMenu(bride, bastok)
        assert(params[1] == groom:getID() and bit.band(bit.rshift(params[0], 14), 3) == sandy.nation)
        bride.events:finish(certificateEventId, 4)
        bride.assert.no:hasItem(bastok.certificate)

        bride:gotoZone(xi.zone.CHATEAU_DORAGUILLE)
        groom:gotoZone(xi.zone.CHATEAU_DORAGUILLE)
        groom.entities:moveTo(getOfficial(groom, sandy.name))
        openMenu(bride, sandy)
        bride.events:finish(certificateEventId, 4)
        bride.assert:hasItem(sandy.certificate)
        assert(bride:getCharVar(issuerVar) == sandy.nation and groom:getCharVar(issuerVar) == sandy.nation)
    end)

    it('allows a first legacy certificate solo and refuses to infer a spouse for its replacement', function()
        local bride, groom, official = spawnCouple(xi.zone.HEAVENS_TOWER)
        groom.actions:leaveParty()
        bride:unequipItem(xi.slot.RING1)
        bride:addItem(xi.item.WEDDING_RING)
        bride:equipItem(xi.item.WEDDING_RING, nil, xi.slot.RING1)
        local params = openMenu(bride, official)
        assert(params[0] == 0x203 and params[1] == 0, 'the original Wedding Ring path was not signaled')
        bride.events:finish(certificateEventId, 2)
        bride.assert:hasItem(official.certificate)
        assert(bride:getCharVar(issuerVar) == official.nation and bride:getCharVar(spouseVar) == 0)

        assert(bride:delItem(official.certificate, 1))
        openMenu(bride, official)
        bride.events:finish(certificateEventId, 2)
        bride.assert.no:hasItem(official.certificate)

        bride.actions:inviteToParty(groom)
        groom.actions:acceptPartyInvite()
        openMenu(bride, official)
        bride.events:finish(certificateEventId, 2)
        bride.assert.no:hasItem(official.certificate)

        bride:equipItem(xi.item.MATRIMONY_BAND, nil, xi.slot.RING1)
        for _, player in ipairs({ bride, groom }) do
            openMenu(player, official)
            player.events:finish(certificateEventId, 4)
            player.assert.no:hasItem(official.certificate)
            assert(player:getCharVar(spouseVar) == 0)
        end
    end)

    it('rechecks the original spouse for a legacy ring replacement', function()
        local bride, groom, official = spawnCouple(xi.zone.HEAVENS_TOWER)
        openMenu(bride, official)
        bride.events:finish(certificateEventId, 4)
        bride.assert:hasItem(official.certificate)
        assert(bride:delItem(official.certificate, 1))
        groom:unequipItem(xi.slot.RING2)
        bride:addItem(xi.item.WEDDING_RING)
        bride:equipItem(xi.item.WEDDING_RING, nil, xi.slot.RING1)

        openMenu(bride, official)
        groom.actions:leaveParty()
        bride.events:finish(certificateEventId, 2)
        bride.assert.no:hasItem(official.certificate)

        bride.actions:inviteToParty(groom)
        groom.actions:acceptPartyInvite()
        openMenu(bride, official)
        bride.events:finish(certificateEventId, 2)
        bride.assert:hasItem(official.certificate)

        assert(bride:delItem(official.certificate, 1))
        bride:gotoZone(xi.zone.METALWORKS)
        groom:gotoZone(xi.zone.METALWORKS)
        local bastok = officials[xi.zone.METALWORKS]
        groom.entities:moveTo(getOfficial(groom, bastok.name))
        openMenu(bride, bastok)
        bride.events:finish(certificateEventId, 2)
        bride.assert.no:hasItem(bastok.certificate)
        assert(bride:getCharVar(issuerVar) == official.nation)
    end)

    it('does not record a marriage when the requesting character cannot receive the certificate', function()
        local bride, groom, official = spawnCouple(xi.zone.CHATEAU_DORAGUILLE)
        for _ = 1, bride:getFreeSlotsCount() do
            bride:addItem(xi.item.BRONZE_CAP)
        end

        openMenu(bride, official)
        bride.events:finish(certificateEventId, 4)

        bride.assert.no:hasItem(official.certificate)
        assert(bride:getCharVar(issuerVar) == 0 and groom:getCharVar(issuerVar) == 0)
        assert(bride:getCharVar(spouseVar) == 0 and groom:getCharVar(spouseVar) == 0)
    end)
end)
