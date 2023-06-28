-----------------------------------
-- Area: Apollyon Central
--  Mob: Gunpod
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addListener("ITEM_DROPS", "GUNPOD_ITEM_DROPS", function(mobArg, loot)
        local result = math.random(1, 100)
        local group = nil
        if result <= 25 then
            -- Apollyon Chips
            group =
            {
                { item = xi.items.SMALT_CHIP },
                { item = xi.items.SMOKY_CHIP },
                { item = xi.items.CHARCOAL_CHIP },
                { item = xi.items.MAGENTA_CHIP },
            }
        elseif result <= 50 then
            -- Craft Materials
            group =
            {
                { item = xi.items.CHUNK_OF_DARKSTEEL_ORE },
                { item = xi.items.CHUNK_OF_ADAMAN_ORE },
                { item = xi.items.DARKSTEEL_INGOT },
                { item = xi.items.DARKSTEEL_SHEET },
                { item = xi.items.SPOOL_OF_RAINBOW_THREAD },
                { item = xi.items.PIECE_OF_OXBLOOD },
                { item = xi.items.HANDFUL_OF_CLOT_PLASMA },
                { item = xi.items.LIGHT_STEEL_INGOT },
                { item = xi.items.PONZE_OF_SHELL_POWDER },
            }
        elseif result <= 86 then
            -- AF+1 Materials
            group =
            {
                { item = xi.items.ARGYRO_RIVET },
                { item = xi.items.ANCIENT_BRASS_INGOT },
                { item = xi.items.SPOOL_OF_BENEDICT_YARN },
                { item = xi.items.SPOOL_OF_DIABOLIC_YARN },
                { item = xi.items.SQUARE_OF_CARDINAL_CLOTH },
                { item = xi.items.SPOOL_OF_LIGHT_FILAMENT },
                { item = xi.items.WHITE_RIVET },
                { item = xi.items.BLACK_RIVET },
                { item = xi.items.FETID_LANOLIN_CUBE },
                { item = xi.items.SQUARE_OF_BROWN_DOESKIN },
                { item = xi.items.SQUARE_OF_CHARCOAL_COTTON },
                { item = xi.items.SHEET_OF_KUROGANE },
                { item = xi.items.POT_OF_EBONY_LACQUER },
                { item = xi.items.BLUE_RIVET },
                { item = xi.items.SQUARE_OF_ASTRAL_LEATHER },
                { item = xi.items.SQUARE_OF_FLAMESHUN_CLOTH },
                { item = xi.items.SQUARE_OF_CANVAS_TOILE },
                { item = xi.items.SQUARE_OF_CORDUROY_CLOTH },
                { item = xi.items.GOLD_STUD },
                { item = xi.items.ELECTRUM_STUD },
            }
        else
            -- Acient Beastcoins
            loot:addItem(xi.items.ANCIENT_BEASTCOIN, xi.drop_rate.GUARANTEED, 5)
            loot:addItem(xi.items.ANCIENT_BEASTCOIN, xi.drop_rate.COMMON)
            return
        end

        loot:addGroup(xi.drop_rate.GUARANTEED, group)
    end)
end

return entity
