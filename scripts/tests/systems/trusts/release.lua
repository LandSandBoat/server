describe('Trust release', function()
    ---@type CClientEntityPair
    local owner
    ---@type CClientEntityPair
    local stranger

    local function trustOf(player)
        for _, member in ipairs(player:getPartyWithTrusts()) do
            if member:isTrust() then
                return member
            end
        end

        return nil
    end

    before_each(function()
        owner    = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        stranger = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        stranger:setPos(owner:getXPos(), owner:getYPos(), owner:getZPos())

        owner:spawnTrust(xi.magic.spell.SHANTOTTO)
        xi.test.world:skipTime(1)
    end)

    it('ignores a release from someone who is not the owner', function()
        local trust = trustOf(owner)
        assert(trust, 'trust was not summoned')

        stranger.actions:trigger(trust)
        xi.test.world:skipTime(3)

        assert(trustOf(owner), 'a stranger released the trust')

        owner.actions:trigger(trust)
        xi.test.world:skipTime(3)

        assert(not trustOf(owner), 'the owner could not release the trust')
    end)
end)
