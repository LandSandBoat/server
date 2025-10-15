-----------------------------------
-- CoP Mission Battlefield Level Caps Module
-- Implements era-appropriate level caps for all CoP mission battlefields
-- Level caps were removed May 2010
-----------------------------------
local m = Module:new('cop_level_caps')

-- Apply level caps after server initialization when all battlefields are loaded
m:addOverride('xi.server.onServerStart', function()
    super()

    local battlefields =
    {
        -- Level 30 Battlefields
        { xi.battlefield.id.ANCIENT_FLAMES_BECKON_SPIRE_OF_HOLLA, 30 },
        { xi.battlefield.id.ANCIENT_FLAMES_BECKON_SPIRE_OF_DEM,   30 },
        { xi.battlefield.id.ANCIENT_FLAMES_BECKON_SPIRE_OF_MEA,   30 },

        -- Level 40 Battlefields
        { xi.battlefield.id.DARKNESS_NAMED,                       40 },
        { xi.battlefield.id.ANCIENT_VOWS,                         40 },

        -- Level 50 Battlefields
        { xi.battlefield.id.SAVAGE,                               50 },
        { xi.battlefield.id.DESIRES_OF_EMPTINESS,                 50 },
        { xi.battlefield.id.HEAD_WIND,                            50 },

        -- Level 60 Battlefields
        { xi.battlefield.id.ONE_TO_BE_FEARED,                     60 },
        { xi.battlefield.id.FLAMES_FOR_THE_DEAD,                  60 },
        { xi.battlefield.id.CENTURY_OF_HARDSHIP,                  60 },

        -- Level 65 Battlefields
        { xi.battlefield.id.CELESTIAL_NEXUS,                      65 },

        -- Level 75 Battlefields
        { xi.battlefield.id.WARRIORS_PATH,                        75 },
        { xi.battlefield.id.WHEN_ANGELS_FALL,                     75 },
        { xi.battlefield.id.DAWN,                                 75 },
    }

    -- Apply level caps to each battlefield
    for _, battlefieldData in pairs(battlefields) do
        local battlefieldId = battlefieldData[1]
        local levelCap = battlefieldData[2]

        local battlefield = xi.battlefield.contents[battlefieldId]
        if battlefield then
            battlefield.levelCap = levelCap
        end
    end
end)

return m
