-----------------------------------
-- Every char_chocobos column survives a save and reload.
-----------------------------------
describe('Chocobo raising storage', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:deleteRaisedChocobo()
    end)

    after_each(function()
        player:deleteRaisedChocobo()
    end)

    it('round trips every column', function()
        -- Distinct values near each column's top, so a swapped or narrowed column shows.
        local saved =
        {
            first_name         = 'Fifteenletterss',
            last_name          = 'Lastname',
            sex                = 1,
            created            = 1700000000,
            last_update_age    = 201,
            stage              = 6,
            location           = 3,
            color              = 4,
            allele1            = 2,
            allele2            = 3,
            allele3            = 4,
            strength           = 250,
            endurance          = 249,
            discernment        = 248,
            receptivity        = 247,
            affection          = 246,
            energy             = 99,
            satisfaction       = 245,
            conditions         = 0x80000401,
            ability1           = 11,
            ability2           = 12,
            personality        = 7,
            weather_preference = 8,
            hunger             = 244,
            care_plan          = 0xF1E2D3C4,
            held_item          = 0x80001234,
            locked_plan        = 13,
            appearance         = 0x61,
            walk_progress      = 0x8004FFFF,
        }

        assert(player:setChocoboRaisingInfo(saved), 'Expected the save')

        local loaded = assert(player:getChocoboRaisingInfo(), 'Expected the reload')
        for column, value in pairs(saved) do
            assert(loaded[column] == value, string.format('%s: saved %s, loaded %s', column, tostring(value), tostring(loaded[column])))
        end
    end)
end)
