-----------------------------------
-- Gajaad donations and the Imperial defense value
-----------------------------------
describe('Gajaad', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        SetServerVariable('[Besieged]ImperialDefense', 100)
        SetServerVariable('[Besieged]ChochoroonCaptured', 0)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.AL_ZAHBI })
        player:addItem({ id = xi.item.IMPERIAL_BRONZE_PIECE, quantity = 99 })
    end)

    it('raises the defense value by 1 per 5 coins donated', function()
        player.actions:tradeNpc('Gajaad', { { itemId = xi.item.IMPERIAL_BRONZE_PIECE, quantity = 14 } })

        assert(GetServerVariable('[Besieged]ImperialDefense') == 102, 'Defense value did not rise by 2')
    end)

    it('stops the defense value at 150', function()
        SetServerVariable('[Besieged]ImperialDefense', 148)
        player.actions:tradeNpc('Gajaad', { { itemId = xi.item.IMPERIAL_BRONZE_PIECE, quantity = 50 } })

        assert(GetServerVariable('[Besieged]ImperialDefense') == 150, 'Defense value went past 150')
    end)

    it('refuses donations while Chochoroon is captured', function()
        SetServerVariable('[Besieged]ChochoroonCaptured', 1)
        player.actions:tradeNpc('Gajaad', { { itemId = xi.item.IMPERIAL_BRONZE_PIECE, quantity = 10 } })

        assert(player:getItemCount(xi.item.IMPERIAL_BRONZE_PIECE) == 99, 'Coins were taken')
        assert(player:getCharVar('walahraCoinCount') == 0, 'Donation was counted')
        assert(GetServerVariable('[Besieged]ImperialDefense') == 100, 'Defense value changed')
    end)
end)
