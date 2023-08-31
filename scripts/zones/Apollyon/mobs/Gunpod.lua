-----------------------------------
-- Area: Apollyon Central
--  Mob: Gunpod
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addListener('ITEM_DROPS', 'GUNPOD_ITEM_DROPS', function(mobArg, loot)
        local result = math.random(1, 100)
        local group
        if result <= 25 then
            -- Apollyon Chips
            group =
            {
                { item = xi.item.SMALT_CHIP },
                { item = xi.item.SMOKY_CHIP },
                { item = xi.item.CHARCOAL_CHIP },
                { item = xi.item.MAGENTA_CHIP },
            }
        elseif result <= 50 then
            -- Craft Materials
            group =
            {
                { item = xi.item.CHUNK_OF_DARKSTEEL_ORE },
                { item = xi.item.CHUNK_OF_ADAMAN_ORE },
                { item = xi.item.DARKSTEEL_INGOT },
                { item = xi.item.DARKSTEEL_SHEET },
                { item = xi.item.SPOOL_OF_RAINBOW_THREAD },
                { item = xi.item.PIECE_OF_OXBLOOD },
                { item = xi.item.HANDFUL_OF_CLOT_PLASMA },
                { item = xi.item.LIGHT_STEEL_INGOT },
                { item = xi.item.PONZE_OF_SHELL_POWDER },
            }
        elseif result <= 86 then
            -- AF+1 Materials
            group =
            {
                { item = xi.item.ARGYRO_RIVET },
                { item = xi.item.ANCIENT_BRASS_INGOT },
                { item = xi.item.SPOOL_OF_BENEDICT_YARN },
                { item = xi.item.SPOOL_OF_DIABOLIC_YARN },
                { item = xi.item.SQUARE_OF_CARDINAL_CLOTH },
                { item = xi.item.SPOOL_OF_LIGHT_FILAMENT },
                { item = xi.item.WHITE_RIVET },
                { item = xi.item.BLACK_RIVET },
                { item = xi.item.FETID_LANOLIN_CUBE },
                { item = xi.item.SQUARE_OF_BROWN_DOESKIN },
                { item = xi.item.SQUARE_OF_CHARCOAL_COTTON },
                { item = xi.item.SHEET_OF_KUROGANE },
                { item = xi.item.POT_OF_EBONY_LACQUER },
                { item = xi.item.BLUE_RIVET },
                { item = xi.item.SQUARE_OF_ASTRAL_LEATHER },
                { item = xi.item.SQUARE_OF_FLAMESHUN_CLOTH },
                { item = xi.item.SQUARE_OF_CANVAS_TOILE },
                { item = xi.item.SQUARE_OF_CORDUROY_CLOTH },
                { item = xi.item.GOLD_STUD },
                { item = xi.item.ELECTRUM_STUD },
            }
        else
            -- Acient Beastcoins
            loot:addItem(xi.item.ANCIENT_BEASTCOIN, xi.drop_rate.GUARANTEED, 5)
            loot:addItem(xi.item.ANCIENT_BEASTCOIN, xi.drop_rate.COMMON)
            return
        end

        loot:addGroup(xi.drop_rate.GUARANTEED, group)
    end)
end

return entity
