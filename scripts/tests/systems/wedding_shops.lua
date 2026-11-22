local packetReader = require('scripts.tests.helpers.packet_reader')

describe('Wedding shops', function()
    local weddingZones =
    {
        xi.zone.CHATEAU_DORAGUILLE,
        xi.zone.METALWORKS,
        xi.zone.HEAVENS_TOWER,
    }

    local function getShop(player, name)
        local shop
        for _, npc in ipairs(player:getZone():queryEntitiesByName(name)) do
            if npc:getStatus() == xi.status.NORMAL then
                assert(not shop, 'more than one active wedding shop named ' .. name)
                shop = npc
            end
        end

        return assert(shop, 'missing active wedding shop ' .. name)
    end

    local function getCofferMessages(player, cofferId, textId)
        local items = {}
        for _, packet in ipairs(player.packets:getIncoming()) do
            if
                packet.type == 0x02A and
                packet.size == 0x20 and
                packetReader.readU32(packet.data, 0x04) == cofferId and
                packetReader.readU16(packet.data, 0x1A) == bit.bor(textId, 0x8000) and
                packet.data[0x1C] == 6
            then
                table.insert(items, packetReader.readU32(packet.data, 0x08))
            end
        end

        return items
    end

    it('sells each character the ring their partner can wear', function()
        for _, zoneId in ipairs(weddingZones) do
            local groom = xi.test.world:spawnPlayer({ zone = zoneId, race = xi.race.HUME_M })
            local bride = xi.test.world:spawnPlayer({ zone = zoneId, race = xi.race.HUME_F })
            local coffer = getShop(groom, 'Matrimonial_Coffer')

            groom:setGil(100000)
            bride:setGil(80000)
            groom.entities:gotoAndTrigger(coffer, { eventId = 2000, finishOption = 2 })
            bride.entities:gotoAndTrigger(coffer, { eventId = 2000, finishOption = 2 })

            groom.assert:hasItem(xi.item.MATRIMONY_BAND)
            bride.assert:hasItem(xi.item.MATRIMONY_RING)
            assert(groom:getGil() == 0 and bride:getGil() == 0)
        end
    end)

    it('announces each piece of a complete set and refuses a set with an owned Rare piece', function()
        local zoneId = xi.zone.CHATEAU_DORAGUILLE
        local ID     = zones[zoneId]
        local groom  = xi.test.world:spawnPlayer({ zone = zoneId, race = xi.race.HUME_M })
        local bride  = xi.test.world:spawnPlayer({ zone = zoneId, race = xi.race.HUME_F })
        local coffer = getShop(groom, 'Matrimonial_Coffer')

        groom:setGil(200000)
        bride:setGil(400000)
        bride:addItem(xi.item.WEDDING_BOOTS)
        groom.entities:gotoAndTrigger(coffer, { eventId = 2000, finishOption = 1 })
        bride.entities:gotoAndTrigger(coffer, { eventId = 2000, finishOption = 1 })

        groom.assert:hasItem(xi.item.BENEDIGHT_COAT)
        groom.assert:hasItem(xi.item.BENEDIGHT_HOSE)
        assert(groom:getGil() == 0)
        local cofferId = coffer:getID()
        local receipt = getCofferMessages(groom, cofferId, ID.text.ITEM_OBTAINED)
        assert(#receipt == 2 and receipt[1] == xi.item.BENEDIGHT_COAT and receipt[2] == xi.item.BENEDIGHT_HOSE)

        bride.assert.no:hasItem(xi.item.BRIDAL_CORSAGE)
        bride.assert.no:hasItem(xi.item.WEDDING_DRESS)
        bride.assert.no:hasItem(xi.item.WEDDING_HOSE)
        assert(bride:getGil() == 400000)
        local refusal = getCofferMessages(bride, cofferId, ID.text.ITEM_CANNOT_BE_OBTAINED)
        assert(#refusal == 1 and refusal[1] == xi.item.WEDDING_BOOTS)
    end)

    it('rolls back a partial purchase and keeps the balance available after zoning', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.CHATEAU_DORAGUILLE })
        local price  = 200000
        local attire = { xi.item.BENEDIGHT_COAT, xi.item.BENEDIGHT_HOSE }
        player:setGil(price)
        player:addItem(xi.item.BENEDIGHT_HOSE)

        -- The coat fits, but the second item is Rare and already owned.
        assert(not player:purchaseItems(attire, price))
        assert(player:getGil() == price)
        player.assert.no:hasItem(xi.item.BENEDIGHT_COAT)
        player:gotoZone(xi.zone.NORTHERN_SAN_DORIA)
        assert(player:getGil() == price)
        player.assert.no:hasItem(xi.item.BENEDIGHT_COAT)
        assert(player:getItemCount(xi.item.BENEDIGHT_HOSE) == 1)

        assert(player:delItem(xi.item.BENEDIGHT_HOSE, 1))
        assert(player:purchaseItems(attire, price))
        assert(player:getGil() == 0)
        player.assert:hasItem(xi.item.BENEDIGHT_COAT)
        player.assert:hasItem(xi.item.BENEDIGHT_HOSE)
    end)

    it('offers the captured retail stock at fixed prices in all three nations', function()
        local expected =
        {
            { xi.item.CRACKER,                 30 },
            { xi.item.TWINKLE_SHOWER,          30 },
            { xi.item.POPSTAR,                 60 },
            { xi.item.BRILLIANT_SNOW,          60 },
            { xi.item.OUKA_RANMAN,             30 },
            { xi.item.LITTLE_COMET,            30 },
            { xi.item.POPPER,                 650 },
            { xi.item.POPPER_II,              650 },
            { xi.item.WEDDING_BELL,          1000 },
            { xi.item.SERENE_SERINETTE,      6000 },
            { xi.item.JOYOUS_SERINETTE,      6000 },
            { xi.item.BOTTLE_OF_GRAPE_JUICE, 1116 },
            { xi.item.INFERNO_CRYSTAL,       3000 },
            { xi.item.CYCLONE_CRYSTAL,       3000 },
            { xi.item.TERRA_CRYSTAL,         3000 },
        }

        for _, zoneId in ipairs(weddingZones) do
            local player = xi.test.world:spawnPlayer({ zone = zoneId })
            player.packets:clear()
            player.entities:gotoAndTrigger(getShop(player, 'Celebratory_Chest'))

            local shopList
            for _, packet in ipairs(player.packets:getIncoming()) do
                if packet.type == 0x03C then
                    shopList = packet
                    break
                end
            end

            assert(shopList, 'expected Celebratory Chest shop packet')
            assert(shopList.size == 0x08 + #expected * 0x0C)
            for index, entry in ipairs(expected) do
                local offset = 0x08 + (index - 1) * 0x0C
                assert(packetReader.readU16(shopList.data, offset + 4) == entry[1])
                assert(packetReader.readU32(shopList.data, offset) == entry[2])
            end
        end
    end)

    it('quotes 20 gil for Popper II in Jeuno and lists it under Alchemy 2', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.LOWER_JEUNO })
        assert(xi.shop.onSellPriceCheck(player, xi.item.POPPER_II, xi.fameArea.JEUNO) == 20)
        assert(GetReadOnlyItem(xi.item.POPPER_II):getAHCat() == xi.itemAHCategory.ALCHEMY_2)
    end)

    it('consumes Popper II and plays its retail animation', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.CHATEAU_DORAGUILLE })
        player:addItem(xi.item.POPPER_II)
        local popper = player:findItem(xi.item.POPPER_II)
        assert(popper)

        player.packets:clear()
        player.actions:useItem(player, popper:getSlotID())
        xi.test.world:tickEntity(player)
        xi.test.world:skipTime(5)

        player.assert.no:hasItem(xi.item.POPPER_II)
        for _, action in ipairs(player.packets:actionPackets()) do
            if
                action.cmd_no == xi.action.category.ITEM_FINISH and
                action.cmd_arg == xi.item.POPPER_II
            then
                assert(action.target[1].result[1].sub_kind == 125, 'wrong Popper II animation')
                return
            end
        end

        assert(false, 'expected Popper II item completion')
    end)

    it('sets all four wedding music slots for the user and their party', function()
        local options = { zone = xi.zone.CHATEAU_DORAGUILLE }
        local player = xi.test.world:spawnPlayer(options)
        local member = xi.test.world:spawnPlayer(options)
        local guest = xi.test.world:spawnPlayer(options)
        player.actions:inviteToParty(member)
        member.actions:acceptPartyInvite()

        player:addItem(xi.item.SERENE_SERINETTE)
        local serinette = player:findItem(xi.item.SERENE_SERINETTE)
        assert(serinette)
        player.packets:clear()
        member.packets:clear()
        guest.packets:clear()
        player.actions:useItem(player, serinette:getSlotID())
        xi.test.world:tickEntity(player)
        xi.test.world:skipTime(5)

        local recipients = { player, member, guest }
        for _, recipient in ipairs(recipients) do
            local count = 0
            for _, packet in ipairs(recipient.packets:getIncoming()) do
                if packet.type == 0x05F then
                    assert(packetReader.readU16(packet.data, 0x04) == count, 'wrong wedding music slot')
                    assert(packetReader.readU16(packet.data, 0x06) == 153, 'wrong Serene Serinette track')
                    count = count + 1
                end
            end

            assert(count == (recipient == guest and 0 or 4), 'wrong number of wedding music packets')
        end
    end)
end)
