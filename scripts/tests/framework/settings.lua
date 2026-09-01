describe('Setting overrides', function()
    local originalRetain

    setup(function()
        originalRetain = xi.test.world:getSetting('map.EXP_RETAIN')
    end)

    it('setSetting applies the override', function()
        xi.test.world:setSetting('map.EXP_RETAIN', 0.5)

        assert(xi.test.world:getSetting('map.EXP_RETAIN') == 0.5, 'Expected the override to be readable')
    end)

    it('the override is restored once the test that set it ended', function()
        assert(xi.test.world:getSetting('map.EXP_RETAIN') == originalRetain, 'Expected the original value to be restored')
    end)

    it('the override reaches Lua readers too', function()
        xi.test.world:setSetting('map.EXP_RETAIN', 0.5)

        assert(xi.settings.map.EXP_RETAIN == 0.5, 'Expected xi.settings to carry the override')
    end)
end)
