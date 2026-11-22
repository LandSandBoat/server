local packetReader = require('scripts.tests.helpers.packet_reader')

describe('Matrimony ring synthesis', function()
    local function synthesize(player, crystalId, ingredients)
        player:addItem(crystalId)
        player.actions:craft(crystalId, ingredients)
        xi.test.world:skipTime(17)
        xi.test.world:skipTime(15)

        player.assert.no:hasItem(crystalId)
    end

    local function forge(player, crystalId, itemId, diamondCount)
        local ingredients = { xi.item.PLATINUM_INGOT, xi.item.PLATINUM_INGOT }
        for _ = 1, diamondCount do
            table.insert(ingredients, xi.item.DIAMOND)
        end

        -- Normal synthesis can break even at the maximum success rate.
        for _ = 1, 5 do
            player:addItem(xi.item.PLATINUM_INGOT, 2)
            player:addItem(xi.item.DIAMOND, diamondCount)

            synthesize(player, crystalId, ingredients)

            if player:hasItem(itemId) then
                player.assert.no:hasItem(xi.item.PLATINUM_INGOT)
                player.assert.no:hasItem(xi.item.DIAMOND)
                assert(player:getItemCount(itemId) == 1)
                return player:findItem(itemId):getSignature()
            end

            player:delContainerItems(xi.inv.INVENTORY)
        end

        error('Matrimony synthesis never succeeded')
    end

    it('forges an unsigned Ring with Fire and signs a Band with Inferno', function()
        xi.test.world:setSeed(1)

        local player = xi.test.world:spawnPlayer({ zone = xi.zone.CHATEAU_DORAGUILLE })
        player:setSkillRank(xi.skill.GOLDSMITHING, xi.craftRank.CRAFTSMAN)
        player:setSkillLevel(xi.skill.GOLDSMITHING, 650)
        player:setMod(xi.mod.SYNTH_SUCCESS_RATE, 300)

        assert(forge(player, xi.item.FIRE_CRYSTAL, xi.item.MATRIMONY_RING, 1) == '')
        assert(forge(player, xi.item.INFERNO_CRYSTAL, xi.item.MATRIMONY_BAND, 5) == player:getName())
    end)

    it('rejects initial synthesis with no Goldsmithing skill', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.CHATEAU_DORAGUILLE })
        player:addItem(xi.item.FIRE_CRYSTAL)
        player:addItem(xi.item.PLATINUM_INGOT, 2)
        player:addItem(xi.item.DIAMOND)

        player.actions:craft(xi.item.FIRE_CRYSTAL, { xi.item.PLATINUM_INGOT, xi.item.PLATINUM_INGOT, xi.item.DIAMOND })

        player.assert:hasItem(xi.item.FIRE_CRYSTAL)
        player.assert.no:hasItem(xi.item.MATRIMONY_RING)
    end)

    it('uses Wind or Cyclone to replace signatures with no Goldsmithing skill', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.CHATEAU_DORAGUILLE })
        player:setMod(xi.mod.SYNTH_SUCCESS_RATE, -100)
        player:addItem({ id = xi.item.MATRIMONY_RING, signature = 'PriorOwner' })
        player:addItem({ id = xi.item.MATRIMONY_BAND, signature = 'PriorOwner' })

        synthesize(player, xi.item.WIND_CRYSTAL, { xi.item.MATRIMONY_RING })
        assert(player:getItemCount(xi.item.MATRIMONY_RING) == 1)
        assert(player:findItem(xi.item.MATRIMONY_RING):getSignature() == '')

        player:setSkillLevel(xi.skill.GOLDSMITHING, 0)
        synthesize(player, xi.item.CYCLONE_CRYSTAL, { xi.item.MATRIMONY_BAND })
        assert(player:getItemCount(xi.item.MATRIMONY_BAND) == 1)
        assert(player:findItem(xi.item.MATRIMONY_BAND):getSignature() == player:getName())
    end)

    it('applies the same engraving rules with a Vortex Crystal', function()
        xi.test.world:setSetting('map.CRAFT_MODERN_SYSTEM', true)
        xi.test.world:setSetting('map.CRAFT_CHANCE_MULTIPLIER', 1.0)
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.CHATEAU_DORAGUILLE })
        player:setSkillRank(xi.skill.GOLDSMITHING, xi.craftRank.RECRUIT)
        player:setSkillLevel(xi.skill.GOLDSMITHING, 110)
        player:setMod(xi.mod.SYNTH_SUCCESS_RATE, -100)
        player:setMod(xi.mod.SYNTH_SKILL_GAIN, 200)
        player:addItem({ id = xi.item.MATRIMONY_RING, signature = 'PriorOwner' })

        synthesize(player, xi.item.VORTEX_CRYSTAL, { xi.item.MATRIMONY_RING })

        assert(player:getItemCount(xi.item.MATRIMONY_RING) == 1)
        assert(player:findItem(xi.item.MATRIMONY_RING):getSignature() == player:getName())
        assert(player:getCharSkillLevel(xi.skill.GOLDSMITHING) == 110)
    end)

    it('allows modern Goldsmithing gains up to 11.0', function()
        xi.test.world:setSetting('map.CRAFT_MODERN_SYSTEM', true)
        xi.test.world:setSetting('map.CRAFT_CHANCE_MULTIPLIER', 1.0)
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.CHATEAU_DORAGUILLE })
        player:setSkillRank(xi.skill.GOLDSMITHING, xi.craftRank.RECRUIT)
        player:setMod(xi.mod.SYNTH_SKILL_GAIN, 200)
        for _, itemId in ipairs({ xi.item.MATRIMONY_RING, xi.item.MATRIMONY_BAND }) do
            player:setSkillLevel(xi.skill.GOLDSMITHING, 109)
            player:addItem(itemId)
            player.packets:clear()

            synthesize(player, xi.item.WIND_CRYSTAL, { itemId })
            assert(player:getCharSkillLevel(xi.skill.GOLDSMITHING) == 110)

            local goldsmithingStatus
            for _, packet in ipairs(player.packets:getIncoming()) do
                if packet.type == 0x062 then
                    goldsmithingStatus = packetReader.readU16(packet.data, 0x80 + 2 * xi.skill.GOLDSMITHING)
                end
            end

            assert(goldsmithingStatus == 11 * 0x20 + xi.craftRank.RECRUIT, 'The guild rank remains uncapped at 11.0')

            player.packets:clear()
            synthesize(player, xi.item.CYCLONE_CRYSTAL, { itemId })
            assert(player:getCharSkillLevel(xi.skill.GOLDSMITHING) == 110)

            local result
            for _, packet in ipairs(player.packets:getIncoming()) do
                if packet.type == 0x06F then
                    result = packet.data
                end
            end

            assert(result and result[0x04] == 0 and result[0x05] == 0 and result[0x06] == 1)
            assert(packetReader.readU16(result, 0x08) == itemId)
            assert(result[0x1A] == xi.skill.GOLDSMITHING, 'The result still identifies Goldsmithing at the ceiling')
        end
    end)
end)
