--- Get the option needed to enter a specific BCNM
---@param player CBaseEntity
---@param bcnmId integer
-- local function getBcnmOption(player, bcnmId)
--     local bcnmIndex = nil
--     for idx, bcnmInfo in ipairs(xi.battlefield.contentsByZone[player:getZoneID()]) do
--         if bcnmInfo.battlefieldId == bcnmId then
--             bcnmIndex = idx - 1
--             break
--         end
--     end
--
--     assert(bcnmIndex ~= nil, 'BCNM not found')
--
--     return bit.lshift(bcnmIndex, 4) + 1
-- end

describe('BCNM', function()
    local client1, player1
    local client2, player2

    before_each(function()
        client1, player1 = xi.test.world:spawnPlayer({ zone = xi.zone.BALGAS_DAIS })
    end)

    it('cant be entered without required item', function()
        -- Add key item so the burning circle opens BCNM menu when triggered.
        player1:addKeyItem(xi.ki.DARK_KEY)

        client1:gotoAndTriggerEntity('BC_Entrance')
        -- TODO: Missing some logic
        --         player1:addItem(xi.item.COMET_ORB)
        --         client1:enterBcnmViaNpc('BC_Entrance', xi.battlefield.id.TREASURE_AND_TRIBULATIONS)

        assert.equal(65535, client1:getCurrentEventId())
        assert.player(player1).no.effect(xi.effect.BATTLEFIELD)
        assert.equal(0, player1:getLocalVar('battlefieldId'))
    end)

    it('can be entered by trading required item', function()
        client2, player2 = xi.test.world:spawnPlayer({ zone = xi.zone.BALGAS_DAIS })

        client1:inviteToParty(player2)
        client2:acceptPartyInvite()

        assert.equal(#player1:getParty(), 2)

        -- Try to enter the orb BCNM via trade
        player1:addItem(xi.item.COMET_ORB)
        client1:enterBcnmViaNpc('BC_Entrance', xi.battlefield.id.TREASURE_AND_TRIBULATIONS, { xi.item.COMET_ORB })

        -- Partied member can now also enter by just triggering without the item
        client2:enterBcnmViaNpc('BC_Entrance', xi.battlefield.id.TREASURE_AND_TRIBULATIONS)
    end)
end)
