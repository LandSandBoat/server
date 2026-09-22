describe('Chocobo Raising', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })
    end)

    after_each(function()
        player:deleteRaisedChocobo()
    end)

    it('saves and reloads raising info without an egg item', function()
        local newChoco = xi.chocoboRaising.newChocobo(player)
        assert(player:setChocoboRaisingInfo(newChoco))

        local info = player:getChocoboRaisingInfo()
        assert(info)
        assert(info.sex == newChoco.sex)
        assert(info.color == newChoco.color)
        assert(info.care_plan == newChoco.care_plan)
    end)
end)
